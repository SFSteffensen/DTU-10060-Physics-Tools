// DTU Template Version Information
// Provides version constants and metadata

#let version = "0.6.3"
#let version-date = datetime(year: 2025, month: 8, day: 15)
#let template-name = "DTU Typst Template"
#let template-description = "Academic note-taking and assignment template following DTU design guidelines"

// Version comparison helpers
#let version-info() = {
  [
    #template-name v#version \
    Released: #version-date.display("[day] [month repr:long] [year]") \
    #template-description
  ]
}

// For debugging and templates that want to show version
#let dtu-version() = version
