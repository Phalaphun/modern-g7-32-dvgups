#import "../component/title.typ": per-line
#import "../utils.typ": long-sign-field

#let work-type-variants = (
  (keys: ("курсовая работа", "курсовая"), title: "Курсовая работа", code: "КР"),
  (keys: ("курсовой проект", "курсовой", "кп"), title: "Курсовой проект", code: "КП"),
  (keys: ("лабораторная работа", "лабораторная", "лр", "лб"), title: "Лабораторная работа", code: "ЛБ"),
  (keys: ("практическая работа", "практическая", "пр"), title: "Практическая работа", code: "ПР"),
  (keys: ("реферат", "рф"), title: "Реферат", code: "РФ"),
  (keys: ("расчётно-графическая работа", "расчетно-графическая работа", "ргр"), title: "Расчётно-графическая работа", code: "РГР"),
)

#let normalize(value) = {
  if value == none { return none }
  lower(str(value))
}

#let ensure-array(value) = {
  if value == none { return () }
  if type(value) == array { return value }
  return (value,)
}

#let pad-two(value) = {
  if value == none { return none }
  let text = str(value)
  if text.len() == 1 { return "0" + text }
  text
}

#let resolve-work-type(value) = {
  let normalized = normalize(value)
  assert(normalized != none, message: "Параметр `work-type` обязателен.")
  for variant in work-type-variants {
    if variant.keys.any(key => normalize(key) == normalized) {
      return variant
    }
  }
  panic("Неизвестный вид работы: " + repr(value))
}

#let arguments(..args, year: auto) = {
  let args = args.named()
  let work-type = resolve-work-type(args.at("work-type", default: none))

  let variant = pad-two(args.at("variant", default: none))
  let work-number = pad-two(args.at("work-number", default: none))
  let specialty = args.at("specialty-code", default: none)

  let group = args.at("group", default: none)

  let code-line = args.at("code", default: none)
  if code-line == none {
    let pieces = ()
    if specialty != none { pieces.push(str(specialty)) }
    if variant != none { pieces.push(variant) }
    if work-number != none { pieces.push(work-number) }
    if group != none { pieces.push(str(group)) }
    code-line = if pieces != () {
      work-type.code + " " + pieces.join(".")
    } else {
      work-type.code
    }
  }

  (
    ministry-lines: ensure-array(args.at("ministry", default: none)),
    university-lines: ensure-array(args.at("university", default: none)),
    department: args.at("department", default: none),
    topic: args.at("topic", default: none),
    work-title: work-type.title,
    discipline: args.at("discipline", default: none),
    work-code: code-line,
    student: args.at("student", default: none),
    advisor: args.at("advisor", default: none),
  )
}

#let template(
  ministry-lines: (),
  university-lines: (),
  department: none,
  topic: none,
  work-title: none,
  discipline: none,
  work-code: none,
  student: none,
  advisor: none,
) = {
  let sized = (content, size) => context {
    set text(size: size)
    content
  }

  // let styled-ministry = ministry-lines.map(line => sized(line, 12pt))
  // let styled-university = university-lines.map(line => sized(line, 12pt))
  // let department-line = if department != none {
  //   sized([Кафедра «#department»], 12pt)
  // } else { none }

  // per-line(
  //   force-indent: true,
  //   ..styled-ministry,
  //   ..styled-university,
  //   (value: department-line, when-present: department-line),
  // )
  // 
  // 
  // 
  // 
  

  let result = (sh, univercity, cafedra) => {
  set par(spacing: 8pt)
  set align(center)
  set text(size:12pt)
  [
    #for c in sh [
      #c\
    ]
    
    #for c in univercity [
      #c\
    ]
    
    #sized([Кафедра «#cafedra»], 12pt)
  ]
 }

 result(ministry-lines,university-lines,department)

  v(1fr)

  per-line(
    align: center,
    indent: 2.5fr,
    (value: sized(topic, 20pt), when-present: topic),
    (value: sized(work-title, 18pt), when-present: work-title),
    (value: sized([дисциплина «#discipline»], 20pt), when-present: discipline),
    (value: sized(upper(work-code), 20pt), when-present: work-code),
  )

  v(0fr)

  let signature-lines = ()
  if student != none {
    signature-lines.push(long-sign-field(student, [Студент], details: "подпись, дата"))
  }
  if advisor != none {
    signature-lines.push(long-sign-field(advisor, [Руководитель], details: "подпись, дата"))
  }

  if signature-lines.len() > 0 {
    for (index, line) in signature-lines.enumerate() {
      line
      if index < signature-lines.len() - 1 {
        v(1fr)
      }
    }
    v(3fr)
  }

  v(0.5fr)
}
