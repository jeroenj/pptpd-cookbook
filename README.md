# pptpd-cookbook
Chef cookbook for pptpd

## Attributes

Minimal set of attributes for two users:

```json
{
  "pptpd": {
    "users": [
      {"username": "david", "password": "bowie"},
      {"username": "billy", "password": "idol"}
    ]
  }
}
```
