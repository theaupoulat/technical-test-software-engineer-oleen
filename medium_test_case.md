# Jeux de test moins faciles

## agenda du conseiller

```yaml
---
- name: "RDV #1"
  start: 2021-03-01T08:00:00Z
  end: 2021-03-01T09:00:00Z
- name: "RDV #2"
  start: 2021-03-01T15:00:00Z
  end: 2021-03-01T16:00:00Z
- name: "RDV #3"
  start: 2021-03-03T10:00:00Z
  end: 2021-03-03T10:30:00Z
- name: "RDV #4"
  start: 2021-03-03T11:10:00Z
  end: 2021-03-03T12:00:00Z
- name: "RDV #5"
  start: 2021-03-03T13:00:00Z
  end: 2021-03-03T14:00:00Z
- name: "RDV #6"
  start: 2021-03-03T14:45:00Z
  end: 2021-03-03T17:00:00Z
```

## horaires de travail du conseille

```yaml
---
- allowDayAndTime: # horaires de travail
  - day: 1
    start: "08:00"
    end: "12:00"
  - day: 1
    start: "13:00"
    end: "17:30"
  - day: 2
    start: "08:00"
    end: "12:00"
  - day: 2
    start: "13:00"
    end: "17:30"
  - day: 3
    start: "08:00"
    end: "12:00"
  - day: 3
    start: "13:00"
    end: "17:30"
- blockSlot: # vacances
  - start: 2021-03-02
    end: 2021-03-02
```

## paramètres
```json
{
  "duration": 30,
  "preparation": 5,
  "from": "2021-03-01T00:00:00Z",
  "to": "2021-03-04T00:00:00Z",
}
```
