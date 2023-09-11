# weather-app

Zadanie polega na stworzeniu prostej aplikacji do sprawdzania prognozy pogody z wykorzystaniem darmowej usługi np. http://apidev.accuweather.com/developers/ lub http://openweathermap.org/api lub dowolnej innej, wybranej przez kandydata, która udostępnia publiczne API.
Wymagania funkcjonalne:<br>
• na pierwszym widoku można wyszukać miasto dla którego chce się zobaczyć prognozę pogody<br>
o nazwa miejscowości ma być walidowana przy pomocy wyrażenia regularnego - § wyszukiwarka nie powinna przyjmować liczb,<br>
§ wyszukiwarka nie powinna przyjmować znaków specjalnych,<br>
§ wyszukiwarka powinna obsługiwać polskie znaki;<br>
o dopasowane miasta mają być widoczne na liście;<br>
• po wybraniu miasta ma nastąpić nawigacja do nowego widoku ze szczegółami prognozy,<br>
• ilość szczegółów prognozy pogody na ekranie szczegółowym jest dowolna; może być<br>
np. temperatura aktualna, stan zachmurzenia, możliwość opadów, tabelka z<br>
temperaturami na najbliższe godziny itd.,<br>
• kolor fontu temperatury ma różnić się w zależności od stopni:<br>
o poniżej 10 stopni Celsjusza kolor niebieski, o między 10 a 20 stopni kolor czarny,<br>
o powyżej 20 kolor czerwony.<br>
Opcjonalnie<br>
• lista z historią wyszukiwania oraz zaimplementowanie zapamiętywania wyszukiwanych miast pomiędzy uruchomieniami aplikacji,<br>
• po przejściu na ekran szczegółów mogą być pobierane dodatkowe dane, np. prognoza na kolejne dni.<br>
Wymagania niefunkcjonalne<br>
• wygląd aplikacji, zasady nawigacji, animacje pozostają w gestii kandydatów, wedle ich wiedzy i przeczucia, tak, aby aplikacja była atrakcyjna i użyteczna,<br>
• aplikacja powinna się uruchamiać na dowolnym urządzeniu z iOS 13 lub wyższym<br>
• Preferowanym językiem jest Swift 5.<br>
• Preferowanym frameworkiem do wykonania interfejsu jest UIKit<br>
