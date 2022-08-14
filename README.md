# Sun Cast is Weather API iOS application

![](https://openweathermap.org/current)



1) Conform to the `<WeatherLoader>` protocol creating an array of `AllWeather`:

![Weather API Diagram]()

2) Follow the backend contract below:

### Remote Weather city Spec

| Property      | Type                |
|---------------|---------------------|
| `id`          | `UUID`              |
| `main`        | `String` (optional) |
| `description  | `String` (optional) |
| `icon`	    | `URL`               |

### Payload contract

```
200 RESPONSE

{
  "weather": [
      { "id": 800,
        "main": "Clear",
        "description": "clear sky",
        "icon": "01n"
       }
    ],
  
  
  "main": {
    "temp": 283.88,
    "feels_like": 282.52,
    "temp_min": 283.88,
    "temp_max": 283.88,
    "pressure": 1011,
    "humidity": 58
  },
  
  
  "timezone": 32400,
  "id": 1851632,
  "name": "Shuzenji",
  "cod": 200
}   
}
```


## Instructions

The goal of this exercise is to get you used to the TDD flow.


6) The `AllWeather` should *not* implement `Decodable` - even in extensions. 

	- That's because the `CodingKeys` to decode the JSON are API-specific details defined in the backend. So declaring the `CodingKeys` in the `AllWeather` will couple it with API implementation details. And since other modules depend on the `AllWeather`, they'll also be coupled with API implementation details.

	- Suggestion: Create an API-specific struct in the 'Weather API' module to perform the decoding. Thus, preventing API details from leaking into other modules. So, for example, if there's a change in the backend, it doesn't propagate everywhere in the codebase. You just update the Feed API module without affecting others.

7) Make careful and proper use of access control (e.g., marking as `private` any implementation details that aren’t referenced from other external components).

8) When all tests are passing and you're done implementing your solution:


10) If instructors request changes in your Pull Request, **only push your changes once you're done with all changes** to avoid running CI for every tiny commit. 

