# Detection Test Cases

| Case | Input | Expected result | Reason |
|---|---|---|---|
| Positive | Event ID 4720 | Match | Local account creation requires review |
| Negative | Event ID 4624 | No match | Successful logon is outside the rule |
| Correlation candidate | 4720 followed by 4732 | Separate review | Group change needs time and asset context |

Record parser version, field mapping, time window, and tuning approval with each test run.
