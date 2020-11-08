We need MySQL setup (workbench and dataset + init)

Aufbau der Datenbank:

- Genre
-

## Diskussion Ausgabe:

Daten vom Jahr 2020!
URL: `:8080/genre/pop`

- Result: for Pop (cache miss)
  - Most heard song: Holy (feat. Chance the Rapper) - Justin Bieber
  - Amount of clicks: 167.539.630
  - What else?

URL: `:8080/genre/rock`

- Result: for Rock (cache miss)
  - Most heard song: Sweet Child O' Mine - Guns N' Roses
  - Amount of clicks: 837.357.700
  - What else?

URL: `:8080/genre/invalid`

- Result: for Invalid (cache miss)
  - Most heard song: not listed
  - Amount of clicks: not listed
  - What else?

URL: `:8080/genres/listed`

- Result:
  - Shortcut | Most heard song 2020 | Band | Clicks on song | Name | Duration (in ms) | Acousticness | Danceability | Energy
  - Pop | Holy | Justin Bieber | 167.539.630 | Pop music | 328 | 0.78 | 0.21 | 0.30
  - ...
