# weather-app

Zadanie polega na stworzeniu prostej aplikacji do sprawdzania prognozy pogody z wykorzystaniem darmowej usługi np. http://apidev.accuweather.com/developers/ lub http://openweathermap.org/api lub dowolnej innej, wybranej przez kandydata, która udostępnia publiczne API.
Wymagania funkcjonalne:
• na pierwszym widoku można wyszukać miasto dla którego chce się zobaczyć prognozę pogody
o nazwa miejscowości ma być walidowana przy pomocy wyrażenia regularnego - § wyszukiwarka nie powinna przyjmować liczb,
§ wyszukiwarka nie powinna przyjmować znaków specjalnych,
§ wyszukiwarka powinna obsługiwać polskie znaki;
o dopasowane miasta mają być widoczne na liście;
• po wybraniu miasta ma nastąpić nawigacja do nowego widoku ze szczegółami prognozy,
• ilość szczegółów prognozy pogody na ekranie szczegółowym jest dowolna; może być
np. temperatura aktualna, stan zachmurzenia, możliwość opadów, tabelka z
temperaturami na najbliższe godziny itd.,
• kolor fontu temperatury ma różnić się w zależności od stopni:
o poniżej 10 stopni Celsjusza kolor niebieski, o między 10 a 20 stopni kolor czarny,
o powyżej 20 kolor czerwony.
Opcjonalnie
• lista z historią wyszukiwania oraz zaimplementowanie zapamiętywania wyszukiwanych miast pomiędzy uruchomieniami aplikacji,
• po przejściu na ekran szczegółów mogą być pobierane dodatkowe dane, np. prognoza na kolejne dni.
Wymagania niefunkcjonalne
• wygląd aplikacji, zasady nawigacji, animacje pozostają w gestii kandydatów, wedle ich wiedzy i przeczucia, tak, aby aplikacja była atrakcyjna i użyteczna,
• aplikacja powinna się uruchamiać na dowolnym urządzeniu z iOS 13 lub wyższym
• Preferowanym językiem jest Swift 5.
• Preferowanym frameworkiem do wykonania interfejsu jest UIKit
