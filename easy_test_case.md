# Jeux de tests faciles

## agenda du conseiller

```yaml
---
- name: "RDV #1"
  start: 2021-03-01T08:00:00Z
  end: 2021-03-01T09:00:00Z
- name: "RDV #2"
  start: 2021-03-01T14:00:00Z
  end: 2021-03-01T19:15:00Z
```

# horaires de travail du conseiller

```yaml
---

- allowDayAndTime: # horaires de travail
  - day: 1 # lundi
    start: "08:00"
    end: "12:00"
  - day: 1 # lundi
    start: "13:00"
    end: "17:30"
```

# paramètres
```json
{
  "duration": 30,
  "preparation": 0,
  "from": "2021-03-01T00:00:00Z",
  "to": "2021-03-02T00:00:00Z",
}
```
