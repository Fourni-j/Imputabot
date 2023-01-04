# Imputabot
Script for PXO imputation

# Setup

You have four properties to update in order to prepare the script. 

```swift
// The first day of the sprint
let sprintStartDate = "2023-01-04T00:00:00+0200"

// Update with your AccountID (Inspect network request to get it)
let authorId = ""

// Update with your own cookie (inspect network request to get it)
let cookies = ""

// Update with the Jira calendar URL
let calendarURL = ""
```

# How to use it

First you need to update the `calendar` property with your schedule, then simply run the script `⌘+R`

```swift
[.sprintPlanning, .wildcard(.automatic, .fill, "PMI-XXX")],                 // mercredi
[.dsm, .wildcard(.automatic, .fill, "PMI-XXX")],                            // jeudi
[.dsm, .wildcard(.automatic, .fill, "PMI-XXX"), .teamBuilding, .wildcard(.automatic, .fill, "PMC-XXX")],          // vendredi
[],                                                                         // dimanche
[],                                                                         // samedi
[.dsm, .wildcard(.automatic, .fill, "PMC-XXX"), .grooming(.afternoon), .wildcard(.automatic, .fill, "PMC-XXX")],  // lundi
[.dsm, .wildcard(.automatic, .fill, "PMI-XXX")],                            // mardi
[.grooming(.noon), .wildcard(.automatic, .fill, "PMI-XXX")],                // mercredi
[.dsm, .wildcard(.automatic, .fill, "PMI-XXX")],                            // jeudi
```