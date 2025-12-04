Data preparation and cleaning 

This step aims to prepare dataset for further analysis by removing duplicates, handling missing data, 

The dataset comprises 113,036 rows and 18 columns before cleaning. 

| Column | Description  | Data type | Missing values | Example values  |
| :---: | :---: | :---: | :---: | :---: |
| **date** | The date order was made | date | 0 | 2011-01-01 |
| **day** | The ordinal number of the day in month | int | 0 | 31 |
| **month** | The name of the month order was made | text | 0 | November |
| **year** | Year of the order | int | 0 | 2015 |
| **customer\_age** | Age of a customer | int | 0 | 19 |
| **customer\_gender** | Male or Female | text | 0 | M, F |
| **age\_group** | Age group to which customer belongs | text | 0 | Adults (35-64) |
| **country** | The country in which order was made | text | 0 | Canada |
| **state** | State in which sale occured | text | 0 | British columbia  |
| **product\_category** | The category of a product | text | 0 | Accessories |
|  |  |  |  |  |

1. **Handling profit, cost, and revenue columns miscalculations** 

The profit column for the first 10 entries shows wrong values according to the standard business formula: **Profit \= Revenue \- Cost**.

Revenue and cost also should be recalculated:

**Revenue \= order\_quantity \* unit\_price**

**Cost \= order\_quantity \* unit\_cost**

I assumed that other entries also had wrong values, so I recalculated 