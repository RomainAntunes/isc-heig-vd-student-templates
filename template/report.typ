#import "@local/isc-heig-vd-student-templates:0.3.0": heig-vd-baseline-logo-lg, hes-so-logo-lg, report

#show: report.with(
  option: (
    lang: "fr",
    type: "draft",
  ),
  doc: (
    title: "Report Title",
    abbr: "Short Title",
    subtitle: "A brief subtitle describing the report",
    logos: (
      tp_topleft: heig-vd-baseline-logo-lg,
      tp_bottomright: hes-so-logo-lg,
    ),
    authors: (
      (
        name: "First Last",
        abbr: "FL",
        email: "first.last@heig-vd.ch",
        url: none,
      ),
    ),
    school: (
      name: "HEIG-VD",
      major: "Informatique et Systèmes de Communication",
      orientation: none,
      url: "https://heig-vd.ch",
    ),
    course: (
      name: "Course Name",
      url: none,
      prof: "Prof. Name",
      class: "ISC",
      semester: "Spring 2026",
    ),
  ),
  tableof: (
    toc: true,
    tof: true,
    tot: false,
    tol: false,
    toe: false,
    maxdepth: 3,
  ),
)

= Introduction

#lorem(50)

== Context

#lorem(80)

= Main Content

#lorem(100)

== Section A

#lorem(60)

== Section B

#lorem(60)

= Conclusion

#lorem(40)
