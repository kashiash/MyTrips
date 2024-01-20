# MapKit

Transkrypcja z wideo na YouTube 



## MapKit z SwiftUI - Regiony, Markery i Adnotacje oraz CameraPosition

https://youtu.be/9xzHJAT_Iqk?si=3PNCiLwANBctonzH

Cześć, nazywam się Stuart Lynch i jest to pierwszy film z nowej serii wprowadzającej ulepszenia MapKit dla SwiftUI. W tej serii zbudujemy całą aplikację i użyjemy SwiftData jako warstwy trwałości do zapisywania lokalizacji naszych map między uruchomieniami. W końcu powinieneś ukończyć coś, co moim zdaniem jest bardzo przydatną aplikacją do dodania do iPhone'a lub iPada. Uwielbiam otrzymywać opinie od użytkowników, więc naciśnij przycisk kciuka w górę, jeśli podobał Ci się ten film i zostaw komentarz poniżej. Upewnij się, że subskrybujesz wideo i dzwonisz, aby otrzymywać powiadomienia o nowych filmach. A jeśli chcesz wesprzeć moją pracę, możesz kupić mi kawę. Pozwól więc, że oprowadzę Cię po aplikacji i zobaczę, co będziemy budować w tej serii. Nazywam tę aplikację MyTrips. A jeśli zamierzasz podążać za mną, powinieneś, ponieważ będziesz uczyć się lepiej i zapamiętasz więcej, gdy będziesz pracować razem ze mną, powinieneś pobrać projekt startowy z linku w opisie tego filmu. I upewnij się, że pobierasz projekt startowy z głównej gałęzi. Ukończony kod źródłowy dla każdego z filmów zostanie udostępniony we własnej gałęzi. Możesz więc pobrać spakowane archiwum z menu kodu. 

​	Kiedy skończymy, aplikacja będzie wyglądać mniej więcej tak. Teraz mogą nastąpić pewne zmiany, ponieważ jest to aplikacja, na której oparłem tę serię, ale może się nieco zmienić, gdy będę bardziej zagłębiał się w tę serię. Kiedy uruchamiam aplikację, jestem przenoszony do mojej bieżącej lokalizacji. Moja aktualna lokalizacja znajduje się tutaj, gdzie jest mój dom. Tak się składa, że zapisałem ten region jako jedno z moich miejsc docelowych, jak wkrótce zobaczysz. Zapisałem kilka lokalizacji, które regularnie odwiedzam, a wszystkie informacje są przechowywane za pomocą SwiftData. Mogę więc powiększyć mapę, wybrać jedną z zaznaczonych lokalizacji i uzyskać podgląd tego obszaru. Mogę zobaczyć, ile czasu zajmie mi jazda samochodem lub nawet spacer. Mogę też otworzyć lokalizację w Mapach Apple. Mogę też wyświetlić trasę w tej aplikacji. Mogę też uzyskać wskazówki krok po kroku. Mogę zmienić wygląd mapy, może satelitarnej z drogami, ustawić wysokość na realistyczną i wybrać wyświetlanie innych punktów widzenia, a może pokazać lub ukryć ruch drogowy. Następnie mogę powiększyć mapę i przejść do trybu 3D. Mogę nawet zmienić nachylenie, aby uzyskać wspaniały widok 3D. A skoro już tu jestem, pozwól, że poszukam kawiarni i zobaczę, czy znajdę taką, która mi się spodoba. Wszystkie te funkcje są dostępne dzięki MapKit dla SwiftUI. Inną zaletą tej aplikacji jest możliwość wykorzystania jej do planowania wakacji. Na karcie miejsc docelowych możesz utworzyć lokalizacje, które chcesz odwiedzić, a w każdym przypadku wybrać region i dodać kilka miejsc, które chcesz odwiedzić. Na mojej aktualnej liście lokalizacji mam już Berlin, Paryż i Vancouver. Gdy odwiedzam każde z miejsc docelowych, region mapy zmienia się, aby pokazać ten region i wszystkie zapisane w nim lokalizacje. Utworzę więc nową lokalizację. Naprawdę chcę wrócić do Sztokholmu, więc chcę dodać go do mojej listy. Gdy dodam tę lokalizację, widok zostanie domyślnie ustawiony na bieżącą lokalizację. Wyszukajmy więc Sztokholm. Następnie mogę dostosować i ustawić region na ten, który chcę odwiedzić. Wyszukam i dodam kilka atrakcji. Po znalezieniu miejsc, które chcę odwiedzić, dodaję je do mojej bazy danych. Zostaną one dodane do tych miejsc dla Sztokholmu. Jedną z atrakcji, której nie widziałem, jest Muzeum Vasa. Pozwól mi je wyszukać. I mogę je dodać. Teraz, gdy odwiedzę Sztokholm i otworzę aplikację, pierwszy ekran pokaże tę lokalizację i wszystkie zapisane znaczniki. Myślę, że to całkiem przydatna aplikacja. Mam więc nadzieję, że pozostaniesz ze mną podczas tworzenia aplikacji. 



Rzućmy więc okiem na projekt startowy. Tak naprawdę nie ma tu zbyt wiele kodu. Wszystko, co zrobiłem, jest następujące. Aplikacja uruchamia się i prezentuje kartę Start, która jest widokiem karty wyświetlającym widok mapy podróży lub widok mapy lokalizacji docelowych.

```swift
struct StartTab: View {
    var body: some View {
        TabView {
            Group{
                TripMapView()
                    .tabItem {
                        Label("TripMap", systemImage: "map")
                    }
                DestinationLocationsMapView()
                    .tabItem {
                        Label("Destinations", systemImage: "globe.desk")
                    }
            }
            .toolbarBackground(.appBlue.opacity(0.8), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}
```

 Zastosowałem również trzy modyfikatory, które mają zastosowanie do paska zakładek, dzięki czemu otrzymałem niebieski pasek zakładek na dole. Każdy z tych widoków znajduje się w osobnej grupie i są to tylko ogólne widoki z pojedynczym widokiem tekstowym. Dodałem kilka zasobów do projektu. Jest kolor akcentujący. Jest też inny kolor o nazwie app blue. Dodałem ikonę aplikacji. Obraz o nazwie Wieża Eiffla. I kolejny obraz o nazwie ekran startowy, który jest używany na naszym ekranie startowym. I wreszcie, kolejny obraz zatytułowany Sacre Coeur. Oto plik scenorysu ekranu startowego, który wyświetla ekran startowy podczas uruchamiania. Dodałem do niego ten obraz ekranu startowego. Ustawiłem również tło, aby używało koloru tła systemowego. Sama aplikacja będzie działać na iPhonie i iPadzie. Ale w przypadku telefonu ograniczyłem orientację tylko do pionowej. I jak widać, dodałem ekran startowy wyświetlający storyboard ekranu startowego podczas uruchamiania. 

Podczas tworzenia tej aplikacji będę pokazywał wiele funkcji dostępnych w API mapy. Nie wszystkie z nich zostaną wykorzystane w naszym projekcie, ale postaram się przedstawić możliwości tam, gdzie to możliwe. Ten pierwszy film jest tego najlepszym przykładem. Ukończony kod będzie znajdował się w gałęzi zatytułowanej V1 Map Marker Annotation Region. Zamierzam pokazać kilka podstawowych funkcji w widoku mapy. Ale w następnym filmie w zasadzie wyrwiemy ten widok i zaimplementujemy nasz projekt, który wykorzystuje dane Swift do utrwalania naszych miejsc docelowych i lokalizacji na naszych urządzeniach między uruchomieniami. 

Zakładka Destinations będzie używana do wyświetlania wszystkich miejsc, które wybraliśmy do odwiedzenia dla danego miejsca docelowego. Gdy ten widok zostanie zaprezentowany, powiększy się do tej konkretnej lokalizacji i przedstawi na mapie wszystkie znaczniki lub adnotacje na mapie do miejsca, które chcemy odwiedzić. Cóż, mapa istnieje od iOS 3 i została udostępniona w SwiftUI i iOS 14. Było to jednak dość ograniczone. Jednak wraz z wprowadzeniem iOS 17 zostało to znacznie ulepszone. Nie jesteśmy jeszcze do końca z parytetem zestawu UI, ale jesteśmy coraz bliżej. Aby utworzyć i pracować z mapą w SwiftUI, musimy najpierw zaimportować zestaw map. Następnie możemy zastąpić dostarczony widok tekstowy prostym widokiem mapy.

```swift
import SwiftUI
import MapKit

struct DestinationLocationsMapView: View {
    var body: some View {
        Map()
    }
}

#Preview {
    DestinationLocationsMapView()
}

```

 Mamy teraz w pełni funkcjonalną mapę wyświetlaną na ekranie, a widok, który otrzymamy, będzie zależał od ustawień regionalnych dla konkretnego urządzenia lub komputera w Xcode. W moim przypadku jestem Kanadyjczykiem, a mój podgląd Xcode został ustawiony na USA i widzę mapę Ameryki Północnej. Zanim przejdę dalej, musisz zapoznać się ze sposobem przesuwania widocznego regionu wyświetlanego na płótnie podglądu lub w symulatorze. 

- Możesz kliknąć i przeciągnąć, co pozwoli ci przesunąć widoczny obszar. Jeśli chcesz powiększyć mapę, możesz to zrobić na kilka różnych sposobów. 
- Możesz kliknąć dwukrotnie i przytrzymać mysz wciśniętą i przeciągnąć, a przeciągnięcie w górę spowoduje powiększenie, a przeciągnięcie w dół - pomniejszenie. 
- Przytrzymanie wciśniętego klawisza Shift, kliknięcie i przeciągnięcie spowoduje dokładnie to samo. Możesz po prostu dwukrotnie stuknąć w wybraną lokalizację, a w miejscu dwukrotnego stuknięcia mapa zostanie przewiercona w dół i możesz kontynuować dwukrotne stukanie i powiększanie dokładnie do miejsca, które chcesz wyświetlić. 
- Jeśli przytrzymasz klawisz opcji na klawiaturze podczas stukania w mapę, będzie to jak dotknięcie dwoma palcami. 
- Szybkie dotknięcie opcji na widoku spowoduje powiększenie tej lokalizacji. Zauważ, że podczas powiększania zawsze pojawia się i znika widok skali mapy. W późniejszym filmie pokażę, jak można kontrolować widoczność i umiejscowienie tego widoku.
-  Jeśli chcesz obrócić mapę, przytrzymaj klawisz opcji na klawiaturze podczas klikania, a następnie przesuń mysz w kierunku zgodnym lub przeciwnym do ruchu wskazówek zegara, aby zasymulować skręcenie dwóch palców. Spowoduje to obrócenie mapy. Gdy to zrobisz, na ekranie pojawi się kontrolka kompasu mapy. 
- Możesz powrócić do wskazywania północy, po prostu dotykając tego kompasu raz, aby wymusić powrót na północ, a następnie kompas zniknie.
-  Po powiększeniu mapy można zmienić nachylenie widoku, przytrzymując klawisze `alt i Shift` i przesuwając ekran w górę lub w dół. 

Zauważyłem, że czasami, gdy to robię, wiele innych elementów sterujących przestaje działać tak, jak powinny w podglądzie i muszę wyjść z trybu na żywo, a następnie ponownie do niego wrócić.

O wiele więcej sukcesów odniosłem z symulatorem. Zazwyczaj po otwarciu aplikacji map widok jest wyśrodkowany wokół bieżącej lokalizacji. I do tego dojdziemy. Ale nie będziemy tego chcieli dla tego konkretnego widoku. W tym widoku dotrzemy tutaj za pomocą stosu nawigacyjnego, który przekaże miejsce docelowe wraz z określonym regionem wyświetlania dla tego miejsca docelowego. 

Aby zademonstrować, jak to działa, załóżmy, że jedziemy do Warszawy i chcemy wyśrodkować nasz widok wokół Pałacyu Kultury. Będzie to jednak wymagało znajomości dwóch rzeczy, współrzędnych centrum, długości i szerokości geograficznej, a także tego, jak daleko na wschód i zachód oraz na północ i południe od tego centrum chcemy wyświetlać naszą mapę. 

Środek może być wyrażony jako instancja obiektu CLLocationCoordinate2D, a rozpiętość lub odległość od tego środka będzie naszą rozpiętością i jest to obiekt MKCoordinateSpan, który będzie wymagał od nas podania delty szerokości i delty długości geograficznej. Ustawmy więc region i kamerę w miejscu, w którym pojawi się nasz widok. Pozycja kamery jest właściwością stanu typu MapCameraPosition i będzie się zmieniać w miarę dostosowywania widoku naszej mapy. Cóż, będzie to wymagało wartości początkowej, więc możemy po prostu użyć automatycznej. Widzieliśmy, że kiedy otworzyłem pierwszy widok mapy, pokazał mi on Amerykę Północną. Następnie możemy utworzyć blok onAppear i w nim dostosować pozycję kamery. 

Najpierw będziemy potrzebować wskazania centrum mapy, a jest to obiekt CLLocationCoordinate2D, który potrzebuje szerokości i długości geograficznej. Cóż, jeśli otworzysz aplikację Mapy na swojej mapie, możesz wyszukać Pałac Kultury i powinien on przenieść Cię bezpośrednio tam i zaprezentować ten ładny mały widok z trzema kropkami w prawym górnym rogu. Jeśli klikniesz na te trzy kropki, zobaczysz, że możesz skopiować współrzędne. 

![image-20240118162154997](image-20240118162154997.png)

Zrobię to i wkleję je tutaj jako komentarz w tym widoku. Widzę, że to moja szerokość i długość geograficzna. Utworzę więc nową instancję, którą nazwę `pkin` jako CLLocationCoordinate2D i przekażę te współrzędne dla szerokości i długości geograficznej. 

```swift
let  pkin = CLLocationCoordinate2D(latitude: 52.231972, longitude: 21.007179)
```

Cóż, rozpiętość to liczba stopni szerokości i długości geograficznej, które chcesz rozciągnąć po obu stronach tego środka. Uważam, że 0.15 to dobra wartość. Utwórzmy więc właściwość wawaSpan, która jest instancją MKCoordinateSpan i użyję tej wartości zarówno dla delt szerokości, jak i długości geograficznej. 

```swift
let wawaSpan = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
```

Regionem jest to, co nazwiemy wawaRegion i jest to instancja MKCoordinateRegion, która wykorzystuje środek, który jest CLLocationCoordinate2D i rozpiętość, która jest MKCoordinateSpan, którą już mamy. Tak więc naszym centrum jest Warszawa, a rozpiętość to WarszawaSpan. Teraz, gdy już to mamy, możemy ustawić pozycję naszej kamery w regionie przy użyciu tego regionu. 

```swift
let wawaRegion = MKCoordinateRegion(center: pkin, span: wawaSpan)
cameraPosition = .region(wawaRegion)
```



A teraz wszystko, co musimy zrobić, to dodać argument pozycji do naszego konstruktora mapView, używając zaktualizowanej i obserwowanej lokalizacji kamery. 

```swift
Map(position: $cameraPosition)
```

Będzie on aktualizowany w miarę dostosowywania naszego widoku, co oznacza, że ostatecznie będziemy w stanie dostosować i zapisać nasz widok dla każdego z naszych różnych miejsc docelowych. 



```swift
struct DestinationLocationsMapView: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    var body: some View {
        Map(position: $cameraPosition)
            .onAppear{
                // 52.231972, 21.007179

              let  pkin = CLLocationCoordinate2D(latitude: 52.231972, longitude: 21.007179)
                let wawaSpan = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
                let wawaRegion = MKCoordinateRegion(center: pkin, span: wawaSpan)
                cameraPosition = .region(wawaRegion)
            }
    }
}
```

Mapa ma zamknięcie MapContentBuilder. W tym miejscu można skonfigurować mapy tak, aby wyświetlały znaczniki lub widoki adnotacji. Przyjrzyjmy się więc im. Znacznik to adnotacja w kształcie balonu, która oznacza lokalizację na mapie. Najprostszym inicjalizatorem jest ten, który akceptuje etykietę znacznika wraz ze współrzędną lokalizacji na mapie. Lokalizacja ta jest obiektem CLLocationCoordinate2D, podobnie jak w przypadku centrum naszego regionu. 

Jeśli więc chcielibyśmy wyświetlić znacznik dla, powiedzmy, Moulin Rouge w Paryżu, możemy określić współrzędne tak, jak pokazałem, gdy uzyskaliśmy współrzędne dla Paryża. Zrobiłem to już i utworzyłem taki znacznik. Etykieta to ciąg "Moulin Rouge", a następnie współrzędne, które CLLocationCoordinate2D dla szerokości geograficznej, która okazała się nieco bardziej skomplikowana, to 48. 884134 i długość geograficzną, która wynosi 2. 332196. Teraz możesz uzyskać własną listę miejsc w Paryżu, aby uzyskać dodatkowe przykłady. Aby jednak zaoszczędzić trochę czasu, stworzyłem rozszerzenie CLLocationCoordinate2D, w którym znalazłem współrzędne dla ośmiu popularnych lokalizacji w Warszawie.

```swift
               let royalCastle = CLLocationCoordinate2D(latitude: 52.248044, longitude: 21.013935)
                let wilanowPalace = CLLocationCoordinate2D(latitude: 52.165955, longitude: 21.090379)
                let oldTownMarketPlace = CLLocationCoordinate2D(latitude: 52.249292, longitude: 21.012072)
                let lazienkiPark = CLLocationCoordinate2D(latitude: 52.214994, longitude: 21.035262)
                let palaceOfCulture = CLLocationCoordinate2D(latitude: 52.231972, longitude: 21.007179)
                let uprisingMuseum = CLLocationCoordinate2D(latitude: 52.232303, longitude: 20.983608)
                let copernicusScienceCentre = CLLocationCoordinate2D(latitude: 52.237368, longitude: 21.028488)
                let polinMuseum = CLLocationCoordinate2D(latitude: 52.250048, longitude: 20.999840)
                let nationalStadium = CLLocationCoordinate2D(latitude: 52.239435, longitude: 21.045450)
                let vistulaRiver = CLLocationCoordinate2D(latitude: 52.237049, longitude: 21.016350)
                let warsawZoo = CLLocationCoordinate2D(latitude: 52.255764, longitude: 20.927787)
                let libraryGarden = CLLocationCoordinate2D(latitude: 52.242944, longitude: 20.986601)
                let chopinMonument = CLLocationCoordinate2D(latitude: 52.238297, longitude: 21.013115)
                let fountainPark = CLLocationCoordinate2D(latitude: 52.239067, longitude: 21.034642)
                let nowySwiatStreet = CLLocationCoordinate2D(latitude: 52.232438, longitude: 21.019693)
```

 

Możesz pobrać to rozszerzenie z gist tutaj. Tworzy ono statyczne właściwości dla czterech różnych miejsc i po prostu zwraca współrzędne. Możesz więc pobrać plik zip i rozwinąć go. Następnie można go przeciągnąć i upuścić w projekcie. 

```swift

import Foundation
import CoreLocation
extension CLLocationCoordinate2D {
    static let royalCastle: Self = .init(latitude: 52.248044, longitude: 21.013935)
    static let wilanowPalace: Self = .init(latitude: 52.165955, longitude: 21.090379)
    static let oldTownMarketPlace: Self = .init(latitude: 52.249292, longitude: 21.012072)
    static let lazienkiPark: Self = .init(latitude: 52.214994, longitude: 21.035262)
    static let palaceOfCulture: Self = .init(latitude: 52.231972, longitude: 21.007179)
    static let uprisingMuseum: Self = .init(latitude: 52.232303, longitude: 20.983608)
    static let copernicusScienceCentre: Self = .init(latitude: 52.237368, longitude: 21.028488)
    static let polinMuseum: Self = .init(latitude: 52.250048, longitude: 20.999840)
    static let nationalStadium: Self = .init(latitude: 52.239435, longitude: 21.045450)
    static let vistulaRiver: Self = .init(latitude: 52.237049, longitude: 21.016350)
    static let warsawZoo: Self = .init(latitude: 52.255764, longitude: 20.927787)
    static  let libraryGarden: Self = .init(latitude: 52.242944, longitude: 20.986601)
    static    let chopinMonument: Self = .init(latitude: 52.238297, longitude: 21.013115)
    static  let fountainPark: Self = .init(latitude: 52.239067, longitude: 21.034642)
    static  let nowySwiatStreet: Self = .init(latitude: 52.232438, longitude: 21.019693)
}

```

Gdy już znajdzie się w projekcie, możesz skomentować ten znacznik i zastąpić go prostszą wersją. W przypadku znacznika etykieta nadal brzmi "Moulin Rouge", ale w przypadku współrzędnych możemy po prostu użyć właściwości statycznej "Moulin Rouge".

```swift
       Marker( "Royal Castle", coordinate: .royalCastle)
```

 Przyjrzyjmy się zatem innym inicjalizatorom wykorzystującym to skrócone rozszerzenie CLLocationCoordinate2D. Mapowanie i czerwony odcień dla markera są domyślne. Możemy jednak wybrać inicjalizator, który pozwala nam podać etykietę. Tak więc dla współrzędnej wybierzmy "Łuk Triumfalny". W przypadku etykiety możemy po prostu użyć ciągu "Arc de Triomphe" i określić, że używamy obrazu systemowego, takiego jak "*. fill". Następnie możemy zastosować odcień, powiedzmy, żółty. 

```swift
            Marker( coordinate: .wilanowPalace)
            {
                Label("Wilanów Palace",systemImage: "star.fill")
            }
            .tint(.yellow)
```

Cóż, znaczniki mogą zaakceptować obraz do użycia jako glif, jeśli nie można go znaleźć w obrazach systemowych. Obraz ten zostanie wyrenderowany jako obraz szablonu. W folderze zasobów dla tego projektu udostępniłem obraz wieży Eiffla, który narysowałem w Sketch. Zamierzam go użyć. Mogę więc określić to dla obrazu, używając Wieży Eiffla i jej współrzędnych, "Wieża Eiffla". 

```swift
Marker( "Warsaw Zoo", image:"orlen",coordinate: .warsawZoo)
```

Ustawmy tutaj odcień na niebieski. Kolejny inicjalizator pozwala nam określić monogram. Stworzę więc jeden dla "Gare du Nord". Jest to tylko widok tekstowy i zaleca się użycie maksymalnie dwóch liter w monogramie. Możemy więc ustawić współrzędne na "Gare du Nord". 

```swift
Marker( "POLIN Museum",monogram: Text("POLIN"), coordinate: .polinMuseum)
```

![image-20240118173805372](image-20240118173805372.png)

A co powiesz na użycie koloru akcentującego naszej aplikacji dla odcienia? Ostatni przykład jest bardzo podobny do drugiego, który stworzyliśmy, z wyjątkiem tego, że nie musimy używać etykiety. Możemy określić ciąg znaków dla znacznika, na przykład "Louvre". Następnie możemy wybrać obraz systemowy, taki jak "person. crop. artframe". 

```swift
Marker( "Copernicus Science Centre",systemImage: "atom", coordinate: .copernicusScienceCentre)
```

![image-20240118173937321](image-20240118173937321.png)

A współrzędne będą dla "Luwru". Opcjonalnie możemy zastosować odcień, taki jak niebieski kolor naszej aplikacji z folderu zasobów. 



Oprócz znaczników można użyć konfigurowalnej adnotacji używanej do wskazania lokalizacji na mapie. Daje nam to bardziej kolorowy i ekscytujący zestaw opcji. Dla przykładu, stwórzmy adnotację używając tytułu, współrzędnych i inicjalizatora zawartości. W tytule użyję po prostu ciągu "Notre Dame". Następnie wybiorę odpowiednią współrzędną. Dla zawartości mogę jednak utworzyć obraz systemowy gwiazdy. Mogę ustawić obraz na dużą skalę, a następnie zastosować czerwony styl pierwszego planu. Mogę dodać trochę wypełnienia, a następnie białe tło i na koniec kształt klipu w kształcie koła. 

```swift
            Annotation("Chopin Monument",coordinate: .chopinMonument) {
                Image(systemName: "star")
                    .imageScale(.large)
                    .foregroundStyle(.red)
                    .padding(10)
                    .background(.white)
                    .clipShape(.circle)
            }
```

![image-20240118173619597](image-20240118173619597.png)

W następnym przykładzie użyję zasobu, który mam w folderze zasobów dla tego przykładowego projektu, gdzie mam pełnokolorowy obraz Sacre Coeur. Możemy więc utworzyć adnotację, w której możemy określić tytuł, współrzędne i niestandardową zawartość, ale możemy również określić pozycję kotwicy. Jako tytuł podam ciąg znaków "Sacre Coeur". Użyjemy odpowiedniej współrzędnej, ale ustawię punkt zakotwiczenia na dot center, co oznacza, że gdziekolwiek treść będzie prezentowana, będzie wyśrodkowana wokół tej konkretnej współrzędnej. W przypadku treści wyświetlmy obraz przy użyciu naszego zasobu. Zmienię jego rozmiar, skalując do dopasowania, a następnie zmniejszę rozmiar, ustawiając ramkę o szerokości i wysokości 40.

```swift
            Annotation("Stara chata",coordinate: .nowySwiatStreet) {
                Image(.staraChata)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40,height: 40)
                    .clipShape(.circle)
            }
```



![image-20240118174319154](image-20240118174319154.png)

 I jeszcze jeden przykład - utwórzmy adnotację dla panteonu. Jako zawartości użyję obrazu systemowego pinezki mapy.

 Skalę obrazu ustawię na dużą, a styl pierwszego planu na czerwony. Cóż, to po prostu umieszcza pinezkę w tej lokalizacji, ale możemy to ulepszyć za pomocą nakładki. Zamierzam więc utworzyć nakładkę, ale najpierw dodam pięć wypełnień, a następnie utworzę nakładkę. W nakładce utworzę okrąg, a następnie zastosuję obramowanie obrysu w kolorze czerwonym z linią dwóch.

```swift
            Annotation("Fountains",coordinate: .fountainPark) {
                Image(systemName: "mappin")
                    .imageScale(.large)
                    .foregroundStyle(.red)
                    .padding(5)
                    .overlay {
                        Circle()
                            .strokeBorder(.red,lineWidth: 2)
                    }
            }
```

![image-20240118174752658](image-20240118174752658.png)

 Aby jeszcze bardziej ulepszyć mapę, MapKit dla SwiftUI obsługuje nakładki na podświetlone obszary na mapie, takie jak okrąg mapy. Wszystko, co musimy zrobić, to podać współrzędne środka. Wybierzmy więc tę, której użyliśmy dla centrum naszego regionu. Dla promienia zastosuję promień 5000. Następnie zastosuję czerwony styl pierwszego planu i ustawię krycie na 0,5.

```swift
            MapCircle(
                center: .palaceOfCulture,
                radius: 5000
            )
            .foregroundStyle(.red.opacity(0.3))
```

 Otrzymamy więc ładny okrąg otaczający te lokalizacje, ale za nimi. 

![Simulator Screenshot - iPhone 15 Pro Max - 2024-01-18 at 17.51.07](Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202024-01-18%20at%2017.51.07.png)

Kontynuując pracę z tą aplikacją, nie będziemy używać żadnych adnotacji ani okręgów na mapie, a jedynie znaczniki. Ale ważne jest, abyś był świadomy tego, co możesz zrobić, aby ulepszyć swoje mapy. Zachęcam więc do zapoznania się z dokumentacją MapKit, aby uzyskać więcej pomysłów na stylizację znaczników lub adnotacji. W miarę przesuwania i dostosowywania naszego widoku będziemy chcieli mieć możliwość przechwytywania i używania nowego regionu oraz zapisywania go. Zacznę więc od dodania nowej właściwości stanu, którą nazwę widocznym regionem. Jest to opcjonalny region współrzędnych MK. Kiedy dostosowujemy nasz widok, uruchamia on funkcję onMapCameraChange. A to zapewnia nam aktualizację kamery mapy w zamknięciu. W tym kontekście, jako region, który możemy przypisać do naszego widocznego regionu, aby go zaktualizować. 

```swift
        .onMapCameraChange(frequency: .onEnd) { context in
            visibleRegion = context.region
        }
```

Teraz nie jest konieczne, abyśmy stale obserwowali zmianę podczas dostosowywania naszego widoku. Tak naprawdę musimy tylko wiedzieć, co to jest, kiedy przestaliśmy się poruszać lub wprowadzać zmiany. Możemy więc dodać argument częstotliwości i określić onEnd. Ponieważ aktualizujemy pozycję naszej kamery, gdy pojawia się widok, widoczny region również zostanie ustawiony. Chociaż nie będziemy tego używać w tym filmie, jest to naprawdę ważna informacja. Pozwoli nam ona zapisać nasz konkretny region wyświetlania dla każdego miejsca docelowego, które tworzymy. A kiedy przejdziemy do wyszukiwania, możemy określić, że chcemy wyszukiwać tylko lokalizacje wokół tego widocznego regionu. 



## Film 2 MapKit z SwiftUI - zapisywanie miejsca docelowego mapy i MockData

https://youtu.be/Z3B8z6WhjCE?si=xC2Uc-czPf74k4Y9

Cześć, nazywam się Stuart Lynch i jest to drugi film z serii MapKit for Swift UI. Zanim przejdziemy do wprowadzenia nowych funkcji MapKit, chcę skonfigurować warstwę trwałości za pomocą SwiftData. Będzie to moja aplikacja MyTrips, którą tworzymy, abyśmy mogli zapisywać nasze miejsca docelowe i znaczniki w naszych telefonach, tak aby następnym razem, gdy uruchomimy aplikację, nadal tam były. Uwielbiam otrzymywać opinie od użytkowników, więc naciśnij przycisk kciuka w górę, jeśli podobał Ci się ten film i zostaw komentarz poniżej. Upewnij się, że zasubskrybowałeś wideo i zadzwoniłeś dzwonkiem, aby otrzymywać powiadomienia o nowych filmach. A jeśli chcesz wesprzeć moją pracę, możesz kupić mi kawę. 

Aplikacja naprawdę nie jest zbyt użyteczna, jeśli wymaga wprowadzania tych samych informacji za każdym razem, gdy ją uruchamiasz.

 To, co musimy zrobić, to dodać do naszej aplikacji sposób na zapisanie miejsc docelowych, które chcemy odwiedzić, wraz ze wszystkimi lokalizacjami, które chcemy odwiedzić w tym miejscu. Tak więc w naszym przykładzie, nad którym pracowaliśmy w ostatnim odcinku, byłaby to nazwa miejsca docelowego, współrzędna środka i region. 

W przypadku poszczególnych lokalizacji do odwiedzenia powinniśmy mieć nazwę i współrzędne każdego z nich, abyśmy mogli odtworzyć znaczniki. Cóż, będziemy to robić przy użyciu Swift Data, nowego frameworka zapisywania danych, który został wprowadzony na WWDC23. 

Cóż, mam kompletną playlistę na ten temat, więc nie będę się w nią zagłębiał aż tak szczegółowo, a link znajduje się w opisie. Ale gorąco polecam również książkę Swift Data Mastery and Swift UI autorstwa Marka Moikinsa z Big Mountain Studio. Link do tej książki również znajduje się w opisie. Powinieneś wiedzieć, że jest to link partnerski i otrzymam prowizję, jeśli użyjesz tego linku do zakupu. Ale powinieneś również wiedzieć, że nigdy nie poleciłbym niczego, co moim zdaniem nie jest tego absolutnie warte. A uwierz mi, ta książka to Biblia na ten temat. 



Cóż, jeśli pracujesz razem ze mną, możesz kontynuować od kodu źródłowego, który ukończyłeś w ostatnim filmie. Jeśli jednak dopiero zaczynasz i chcesz pracować razem ze mną, możesz pobrać ukończony projekt z ostatniego filmu. Link znajduje się w opisie. Upewnij się tylko, że pobierasz go z gałęzi z filmu 1. Możesz zobaczyć, że uruchomiłem już nową gałąź dla tego filmu, a ukończony kod źródłowy dla tego filmu będzie w tej gałęzi. Linki do obu gałęzi znajdują się w opisie. Uporządkujmy więc nasz kod w projekcie. Utworzę więc nowy folder o nazwie "`Models`". 

W tym folderze utworzę nowy plik i nazwę go "`Destination`". Będę potrzebował `SwiftData` i `MapKit`, więc będę musiał zaimportować oba te frameworki. Następnie mogę utworzyć klasę o nazwie "Destination". A ponieważ używamy `SwiftData`, zamierzam udekorować ją makrem `@Model`. Miejsce docelowe będzie potrzebowało nazwy, więc utworzę dla niego właściwość typu string, abyśmy mogli podać tę nazwę podczas tworzenia miejsca docelowego. Cóż, aby utworzyć region, musimy znać jego środek, który jest CLLocationCoordinate2D, i rozpiętość, która jest MKCoordinateSpan, i nauczyliśmy się tego w ostatnim filmie. Problem polega na tym, że żaden z tych typów obiektów nie może być przechowywany bezpośrednio w SwiftData. Jednak te komponenty składają się po prostu z podwójnych wartości. Szerokość i długość geograficzna, delta szerokości i delta długości geograficznej to po prostu wartości podwójne.

```swift
import Foundation
import SwiftData
import MapKit

@Model
class Destination {
    var name: String
    var latitude: Double?
    var latitudeDelta: Double?
    var longitude: Double?
    var longitudeDelta: Double?
  ...
}
```

 Inną kwestią, z którą będziemy mieć do czynienia, jest to, że kiedy utworzymy miejsce docelowe w naszej aplikacji, nie będziemy jeszcze mieć naszego regionu. Będziemy więc musieli uczynić je opcjonalnymi. Tak więc te właściwości, które teraz tworzymy dla tych czterech różnych podwójnych wartości, będą opcjonalne. Cóż, SwiftData wymaga inicjalizatora, więc pozwolimy Xcode wygenerować go dla nas zaczynajac wpisywac slowo init... Super proste. 

```swift
    init(name: String, latitude: Double? = nil, latitudeDelta: Double? = nil, longitude: Double? = nil, longitudeDelta: Double? = nil) {
        self.name = name
        self.latitude = latitude
        self.latitudeDelta = latitudeDelta
        self.longitude = longitude
        self.longitudeDelta = longitudeDelta
    }
```

Region może zostać utworzony jako obliczona właściwość opcjonalnego typu MKCoordinateRegion. Pamiętaj, że nie będziemy go mieć, gdy po raz pierwszy utworzymy nasze miejsce docelowe. Cóż, jeśli użyjemy if let, jeśli wszystkie nasze właściwości nie są opcjonalne, możemy zwrócić MKCoordinateRegion zapewniający środek i rozpiętość. Używamy więc if let. 

```swift
    var region: MKCoordinateRegion? {
        if let latitude, let longitude, let latitudeDelta, let longitudeDelta {
```

Cóż, środkiem jest CLLocationCoordinate2D, a następnie nasza szerokość i długość geograficzna są po prostu tymi, które przekazaliśmy. A rozpiętość będzie MKCoordinateSpan przy użyciu tej szerokości geograficznej, delty i delty długości geograficznej. Teraz, jeśli funkcja if let nie powiedzie się, ponieważ nadal nie określiliśmy wartości szerokości, długości i delty, po prostu zwrócimy nil. 

```swift
@Model
class Destination {
    var name: String
    var latitude: Double?
    var latitudeDelta: Double?
    var longitude: Double?
    var longitudeDelta: Double?

    init(name: String, latitude: Double? = nil, latitudeDelta: Double? = nil, longitude: Double? = nil, longitudeDelta: Double? = nil) {
        self.name = name
        self.latitude = latitude
        self.latitudeDelta = latitudeDelta
        self.longitude = longitude
        self.longitudeDelta = longitudeDelta
    }

    var region: MKCoordinateRegion? {
        if let latitude, let longitude, let latitudeDelta, let longitudeDelta {
            return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude , longitude: longitude),
                                      span: MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta))
        } else {
            return nil
        }
    }
}
```

​	

Cóż, potrzebujemy kolejnej klasy, aby utworzyć każdy z naszych markerów lub POI. W folderze models utworzę więc kolejny plik o nazwie MTPlacemark. Jest to skrót od My Trip Placemarks. I zaimportuję SwiftData i MapKit. Utwórz nową klasę o nazwie MTPlacemarks, tak jak to zrobiliśmy dla naszego miejsca docelowego, i upewnij się, że udekorowałeś ją makrem @Model. Znaczniki muszą znać nazwę i współrzędne. Podobnie jak w przypadku miejsca docelowego, współrzędną jest CLLocationCoordinate2D. 

```swift
import MapKit

@Model
class MTPlacemark {
    var name: String
    var address: String
    var latitude: Double?
    var longitude: Double?

}
```

Struktury CLLocationCoordinate2D, ponownie, SwiftData nie może zapisać, więc będziemy musieli rozbić na części i odtwarzać go z szerokości i długości geograficznej. I jest jeszcze jedna rzecz, którą będziemy mogli uzyskać, gdy wyszukamy naszą lokalizację na mapie, a będzie to jej adres. Żaden z tych elementów nie musi być opcjonalny, ponieważ otrzymujemy je wszystkie podczas wyszukiwania w celu utworzenia nowych znaczników. Tak więc nazwa jest ciągiem znaków, podobnie jak adres, ale szerokość i długość geograficzna są podwójne. I znowu, pozwolimy Xcode stworzyć dla nas inicjalizator. 

Wrócę do tej klasy później i dodam więcej obliczanych właściwości, ale jest jeszcze jedna rzecz, którą musimy zrobić, aby połączyć te dwie różne klasy, a mianowicie ustanowienie relacji. Jeśli nasze znaki miejsc są powiązane z miejscem docelowym, co oznacza, że zakończyliśmy wyszukiwanie i zdecydowaliśmy, że chcemy powiązać konkretny punkt z jednym z naszych miejsc docelowych, możemy utworzyć właściwość `Destination` tutaj w naszej klasie i nazwiemy ją miejscem docelowym i będzie ona typu miejsce docelowe. Jednak gdy jestem w tej lokalizacji, mogę po prostu wyszukiwać inne lokalizacje, ale dodawać tylko niektóre z nich, więc będziemy musieli uczynić tę właściwość opcjonalną. 

```swift
  var destination: Destination?
```

To ustawia relację tutaj jako relację jeden-do-jednego z miejscem docelowym. Ale jeśli wrócimy teraz do naszej klasy `Destination`, możemy dodać tutaj kolejną właściwość, która będzie tablicą tych pustych znaczników miejsc, a kiedy ją zainicjujemy, będzie to pusta tablica. Kiedy jednak usuniemy tutaj miejsce docelowe, będziemy chcieli upewnić się, że usunęliśmy wszystkie powiązane z nim znaczniki miejsc, abyśmy mogli następnie udekorować je makrem @relationship, a następnie określić, że reguła usuwania jako argument jest kaskadowa. 

```swift
class Destination {
    ...
    var longitudeDelta: Double?
  
    @Relationship(deleteRule: .cascade)
    var placemarks: [MTPlacemark] = []
  ...
```



Teraz, gdy skonfigurowaliśmy nasze tabele, musimy upewnić się, że xcode tworzy ten kontener modelu, a wszystko to zostało omówione w Swift Data Series i doskonałej książce Marka. Wracając do punktu wyjścia, aplikacji MyTrips, musimy zakończyć konfigurację, dodając funkcję Swift Data do grupy okien. Najpierw musimy zaimportować Swift Data, a następnie możemy dołączyć funkcję kontenera modelu dla typu docelowego self do grupy okien. A ponieważ miejsce docelowe ma związek z pustymi danymi placemark, musimy tylko określić tutaj typ miejsca docelowego. 

```swift
import SwiftUI
import SwiftData

@main
struct MyTripsApp: App {
    var body: some Scene {
        WindowGroup {
            StartTab()
        }
        .modelContainer(for: Destination.self)
    }
}
```

To wszystko, jeśli chodzi o konfigurację Swift Data. O wiele łatwiejsze niż w przypadku Core Data. 



Bardzo lubię korzystać z podglądu w SwiftUI, więc chcę mieć kilka próbek do pracy, aby móc zbudować interfejs użytkownika i zobaczyć, jak będzie wyglądał bez konieczności uruchamiania symulatora. Aby to ułatwić, zamierzam użyć tego samego miejsca docelowego, Warszawy i lokalizacji, dla których utworzyłem znaczniki w naszym pierwszym filmie, aby utworzyć przykładowe makiety danych. Zrobimy to w sposób, który zademonstrował mi Mark Moykenes w swojej książce. W pliku `Destination` utworzę nowe rozszerzenie w miejscu docelowym. A to, co musimy zrobić, to utworzyć kontener, który jest przechowywany tylko w pamięci, więc nie utrzymuje się w podglądzie. 

Jest on tworzony za każdym razem, gdy przechodzimy do podglądu na żywo. Utworzymy więc statyczną właściwość obliczaną o nazwie preview, która jest typu model container. A teraz w tym miejscu możemy utworzyć właściwość kontenera, ale będziemy musieli użyć wymuszonej próby, ponieważ może się to nie powieść i utworzyć kontener modelu dla miejsca docelowego. self, co w pewnym sensie zrobiliśmy podczas tworzenia naszej aplikacji w punkcie uruchamiania aplikacji. 

```swift
extension Destination {
    static var preview: ModelContainer {
        let container = try! ModelContainer(
            for: Destination.self,
            configurations: ModelConfiguration(
                isStoredInMemoryOnly: true
            )
        )
      // tu trzeba utworzyc demonstracyjny obiekt Destination i kilka powwiązanych   MTPlacemark
        return container
    }
}
```

Ale określimy również konfigurację, która jest prostą konfiguracją modelu, gdzie przechowywana w pamięci jest ustawiona na true. Jeśli więc użyjemy tego kontenera w naszych podglądach, nie będziemy w ogóle utrwalać żadnych danych na dysku. 

Zanim jednak zwrócę kontener, możemy utworzyć mock data i dodać je do tego kontenera w pamięci. Więc najpierw miejsce docelowe. Jak już wspomniałem, chcę użyć tych samych współrzędnych i regionu, których użyłem w pierwszym filmie. Wrócę więc do widoku mapy lokalizacji docelowych, gdzie używam współrzędnych lokalizacji CL 2D oraz regionu i rozpiętości w naszych danych Swift. Możemy je po prostu skopiować. Wkleję je i skomentuję w moim nowym rozszerzeniu modelu miejsca docelowego. Najpierw utworzymy miejsce docelowe. Będę więc potrzebował obiektu docelowego. Ale ponieważ znam wszystkie argumenty, mogę przytrzymać klawisz Option na klawiaturze, aby uzyskać wszystkie opcjonalne podwójne argumenty. A następnie rozdzielę je na osobne linie, aby ułatwić wprowadzanie. Nazwę więc to Warszawa. Następnie mogę po prostu skopiować i wkleić wartości, które właśnie wkleiłem z góry jako komentarz. Następnie, korzystając z danych Swift, mogę użyć głównego kontekstu kontenerów, aby wstawić ten model Warszawa do pamięci. Następnie chcę utworzyć kilka znaczników, które zostaną zbudowane z pustych znaczników miejsc. Będziemy więc potrzebować tablicy znaczników miejsc, którą następnie dołączymy do tablicy będącej tablicą znaczników miejsc docelowych Paryża. Cóż, mam prawie wszystko, czego potrzebuję do moich przykładowych lokalizacji w Paryżu. Brakuje tylko nazwy i adresu. Możesz je wymyślić lub pobrać z przewodnika, który wkrótce ci pokażę. Na przykład dla Luwru mógłbym skonstruować nasz znacznik miejsca w ten sposób, używając pustego inicjalizatora znacznika miejsca. I mogę użyć Louvre Museum jako nazwy. Odkryłem, że adres to 93 Rue de Rivoli w 75-001 Paryż, Francja. Szerokość geograficzna to 48. 861950, a długość geograficzna 2. 336902. Cóż, mógłbym kontynuować w ten sam sposób dla pozostałych. To trochę nużące. Użyj do wypenienia chat gpt. 



```swift
extension Destination {
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(
            for: Destination.self,
            configurations: ModelConfiguration(
                isStoredInMemoryOnly: true
            )
        )


        let wawa = Destination(name: "Warszawa",
                               latitude: 52.231972,
                               latitudeDelta: 0.15,
                               longitude:21.007179 ,
                               longitudeDelta: 0.15
        )
        container.mainContext.insert(wawa)

        var placemarks: [MTPlacemark] {
            [
             MTPlacemark(name: "Royal Castle", address: "Warsaw", latitude: 52.248044, longitude: 21.013935)
             MTPlacemark(name: "Wilanow Palace", address: "Warsaw", latitude: 52.165955, longitude: 21.090379)
            MTPlacemark(name: "Old Town Market Place", address: "Warsaw", latitude: 52.249292, longitude: 21.012072)
            MTPlacemark(name: "Lazienki Park", address: "Warsaw", latitude: 52.214994, longitude: 21.035262)

             MTPlacemark(name: "National Museum", address: "Aleje Jerozolimskie 3, Warsaw", latitude: 52.231959, longitude: 21.007699)

             MTPlacemark(name: "Copernicus Science Center", address: "Wybrzeże Kościuszkowskie 20, Warsaw", latitude: 52.2396, longitude: 21.0445)

             MTPlacemark(name: "Warsaw Uprising Museum", address: "Grzybowska 79, Warsaw", latitude: 52.2326, longitude: 20.9827)

             MTPlacemark(name: "Palace of Culture and Science", address: "Plac Defilad 1, Warsaw", latitude: 52.231923, longitude: 21.005184)

             MTPlacemark(name: "Powązki Cemetery", address: "Powązkowska 8, Warsaw", latitude: 52.260816, longitude: 20.984171)

             MTPlacemark(name: "Wilanów Park", address: "Stanisława Kostki Potockiego 10/16, Warsaw", latitude: 52.165625, longitude: 21.103261)

             MTPlacemark(name: "Chopin Museum", address: "Ostrogski Palace, Okólnik 1, Warsaw", latitude: 52.239666, longitude: 21.013574)

             MTPlacemark(name: "Praga District", address: "Targowa 74, Warsaw", latitude: 52.252812, longitude: 21.043453)

             MTPlacemark(name: "Zoo Warsaw", address: "Ratuszowa 1/3, Warsaw", latitude: 52.237148, longitude: 20.987155)

             MTPlacemark(name: "Polish Vodka Museum", address: "Wierzbowa 9/11, Warsaw", latitude: 52.247754, longitude: 21.005517)

             MTPlacemark(name: "Holy Cross Church", address: "Krakowskie Przedmieście 3, Warsaw", latitude: 52.238349, longitude: 21.017532)

             MTPlacemark(name: "Saxon Garden", address: "Marszałkowska 10/16, Warsaw", latitude: 52.238879, longitude: 21.015677)

             MTPlacemark(name: "Multimedia Fountain Park", address: "Saski Park, Warsaw", latitude: 52.242515, longitude: 21.013608)

             MTPlacemark(name: "Praski Park", address: "Park Praski, Warsaw", latitude: 52.250032, longitude: 21.056926)

             MTPlacemark(name: "Museum of the History of Polish Jews", address: "Anielewicza 6, Warsaw", latitude: 52.250778, longitude: 20.999187)


             ]
        }

        placemarks.forEach { placemark in
            wawa.placemarks.append(placemark)
        }

        return container
    }
}

```

Ponieważ jest to tablica, mogę użyć for each na tablicy znaków miejsca. Dostarczy mi to iterator znaczników miejsc, który mogę następnie dołączyć do tablicy znaczników miejsc Warszawa. A teraz, gdy to wszystko zostało zrobione, ten kontener powróci z miejscem docelowym i jego tablicą. 



Aby zakończyć ten film, wykorzystajmy te pozorowane dane na mapie lokalizacji naszego miejsca docelowego, aby wyświetlić nasze znaczniki miejsc MK jako znaczniki na mapie. 

Po pierwsze, jeśli zamierzamy uzyskać dostęp do naszych przechowywanych danych, musimy zaimportować dane Swift. 

```swift
import SwiftUI
import MapKit
import SwiftData

struct DestinationLocationsMapView: View {
```

Następnie usunę wszystkie znaczniki i adnotacje z zamknięcia kreatora widoku mapy, te, które utworzyliśmy w ostatnim filmie. 

```swift
struct DestinationLocationsMapView: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var visibleRegion: MKCoordinateRegion?
    var body: some View {
        Map(position: $cameraPosition) {

            //tu usnalem i dodam teraz z bazy
        }
        .onMapCameraChange(frequency: .onEnd) { context in
```

Następnie usunę zawartość bloku on appear, a region mapy powinien powrócić do regionu lokalizacji, automatycznej pozycji kamery. 

Cóż, aby uzyskać nasze pojedyncze miejsce docelowe z wielu, musimy wykonać zapytanie o dane Swift. W następnym filmie zmienimy sposób, w jaki dotrzemy do tego punktu, ale pozwoli nam to przetestować nasze modele danych Swift, tak jak je skonfigurowaliśmy. Możemy więc użyć makra zapytania o dane Swift, aby pobrać tablicę wszystkich możliwych miejsc docelowych, które możemy mieć w naszej przechowywanej bazie danych. Mamy tylko jeden Warszawa, ale ostatecznie może być ich wiele. Będziemy jednak chcieli pobrać tylko jeden, więc będziemy musieli utworzyć tutaj właściwość stanu o nazwie destination, która jest typu destination. 

```swift

    @Query private var destinations: [Destination]
    @State private var destination: Destination?

```

Musimy uczynić ją opcjonalną, ponieważ kiedy po raz pierwszy zbudujemy tę aplikację, nie będzie żadnej. A następnie w bloku on appear przypiszemy pierwsze z miejsc docelowych pobierania do właściwości destination. 



Teraz nadal będzie to opcjonalne. Będziemy więc musieli użyć if let dla regionu, aby uzyskać ten obliczony region docelowy, jeśli istnieje. A następnie przypisać pozycję kamery do tego regionu dla miejsca docelowego. I tak, miejsce docelowe było opcjonalne, więc będziemy musieli użyć tego znaku zapytania. Cóż, mapa nadal się nie zmieniła, ponieważ musimy powiedzieć podglądowi, że chcemy użyć kontenera naszych makiet danych. Tak więc w makrze podglądu po prostu dodamy kontener modelu, a następnie dostarczymy rzeczywisty kontener, którym jest podgląd właściwości statycznej z miejsca docelowego. 

```swift
#Preview {
    DestinationLocationsMapView()
        .modelContainer(Destination.preview)
}

```

Mapa powinna być teraz wyśrodkowana wokół Paryża. Jak dotąd, dobrze. Dla zawartości mapy będziemy musieli utworzyć znaczniki przy użyciu każdego z naszych znaczników miejsca z naszej tablicy znaczników miejsca w naszym miejscu docelowym. Ale do tego będziemy potrzebować współrzędnych lokalizacji CL 2D. A nasz znacznik miejsca MK jej nie ma. Wróćmy więc do klasy znacznika `MTPlacemark` i utwórzmy właściwość obliczaną, która skonstruuje tę współrzędną z naszej szerokości i długości geograficznej.

```swift
    var coordinate: CLLocationCoordinate2D{
        .init(latitude: latitude, longitude: longitude)
    }
```

 Jest to więc współrzędna lokalizacji CL 2D, a następnie możemy po prostu użyć inicjalizatora zapewniającego szerokość i długość geograficzną. Wracając do widoku mapy lokalizacji docelowej w kreatorze zawartości mapy, możemy najpierw sprawdzić, czy mamy miejsce docelowe, używając instrukcji if let. 

```swift
        Map(position: $cameraPosition) {
            if let destination {
```

Jeśli tak, możemy użyć pętli for each na znacznikach miejsca docelowego, aby dostarczyć nam iterator znaczników miejsca, którego możemy użyć do utworzenia naszych znaczników. 

```swift
                ForEach(destination.placemarks) {placemark in
                    Marker(coordinate: placemark.coordinate) {
                        Label(placemark.name,systemImage: "star")
                    }
```

. Współrzędną będzie więc współrzędna znacznika miejsca. Następnie możemy skonstruować etykietę przy użyciu `placemark.name` i `systemImage` użyję po prostu gwiazdy. Następnie zastosuję żółty odcień na całym `Markerze`. 

```swift
        Map(position: $cameraPosition) {

            if let destination {
                ForEach(destination.placemarks) {placemark in
                    Marker(coordinate: placemark.coordinate) {
                        Label(placemark.name,systemImage: "star")
                    }
                    .tint(.yellow)
                }
            }
        }
```

Teraz wszystkie nasze znaczniki, które mamy w naszych danych znaczników, są wyświetlane w naszym regionie, który został określony jako Warszawa. 

## Film 3 MapKit z SwiftUI - Lista miejsc docelowych i nawigacja

https://youtu.be/7MbagyBB9VM?si=19QIYquaM4ebkPpf



Teraz, gdy dodaliśmy makiety danych do naszego kontenera podglądu, możemy zacząć budować naszą aplikację. Będziesz chciał zaplanować więcej niż jedną podróż wraz z lokalizacjami do odwiedzenia w miejscu docelowym, więc od tego zaczniemy ten film. Jeśli pracujesz ze mną, możesz kontynuować od kodu źródłowego, który ukończyłeś w ostatnim filmie. Jeśli jednak dopiero zaczynasz i chcesz pracować razem ze mną, możesz pobrać ukończony projekt z ostatniego filmu. Link znajduje się w opisie poniżej. Jeśli chodzi o moje repozytorium GitHub, po prostu upewnij się, że pobrałeś gałąź z filmu 2. Możesz już zobaczyć, że teraz wróciłem do mojego projektu, uruchomiłem teraz nową gałąź dla tego filmu, a ukończony kod źródłowy tego filmu będzie w tej gałęzi. Linki do obu będą w opisie. 

Zacznijmy więc od utworzenia nowego widoku SwiftUI w folderze zakładki `Destinations` i nazwiemy go `DestinationsListView`. Użyjemy go do wyświetlenia listy wszystkich naszych miejsc docelowych i stworzymy sposób na tworzenie nowych. 

Ponieważ mamy do czynienia ze SwiftData, najpierw zaimportujmy SwiftData. Aby wyświetlić listę wszystkich miejsc docelowych, musimy pobrać wszystkie nasze `Destinations` za pomocą zapytania SwiftData. Chcę, aby  były posortowane według nazwy, więc w moim zapytaniu mogę dodać argument sortowania. A to posortuje je rosnąco. W wyniku otrzymamy miejsca docelowe jako tablicę.

```swift
  @Query(sort: \Destination.name) private var destinations: [Destination]
```

Cóż, ponieważ chcemy użyć danych z naszego kontenera podglądu na liście, możemy zastosować funkcję kontenera modelu dla podglądu miejsca docelowego w naszym makrze podglądu. 

```swift
#Preview{
    DestinationsListView()
        .modelContainer(Destination.preview)
}
```

Na szczęście wszystkie modele SwiftData są zgodne z protokołem identyfikowalności, więc mogę utworzyć listę, która wyświetli te lokalizacje, ale chcę to zrobić tylko wtedy, gdy nie jest to pusta tablica. Jeśli jest pusta, zamierzam wyświetlić widok `ContentUnavailableView`, aby poinformować naszych użytkowników, że powinni go utworzyć. Ale najpierw stwórzmy nasze sprawdzenie dla naszej listy. Zamierzam więc otoczyć widok tekstowy instrukcją if-else, która sprawdza ten przypadek. A następnie dla klauzuli else utworzę widok `ContentUnavailableView`, który ma tytuł, system, obraz i opis. W tytule użyję ciągu "Brak miejsc docelowych". " A następnie dla obrazu systemu użyję "globe. desk. W przypadku opisu użyję widoku tekstowego i zacznę od ciągu "Nie skonfigurowano jeszcze żadnych miejsc docelowych". " Stuknij w. (W tym momencie chcę wyświetlić obraz, który będzie na moim pasku narzędzi. Użyję więc interpolacji ciągów znaków, aby wyświetlić obraz o nazwie systemowej " . circle. fill.". ") A następnie mogę kontynuować z moim ciągiem znaków ze spacją, a następnie przyciskiem na pasku narzędzi, aby rozpocząć.

```swift
                if !destinations.isEmpty {
                    Text("Hello world")
                } else {
                    ContentUnavailableView("No Destinations", systemImage: "globe.desk", description: Text("You have not se up any destinations yet. Tap on the \(Image(systemName: "plus.circle.fill")) button in the toolbar to begin"))
                }
```

 Teraz możesz się zastanawiać, dlaczego wyświetlany jest napis "Hello World". Cóż, powodem jest to, że użyliśmy naszego kontenera modelu, a pobieranie znalazło tę pojedynczą lokalizację Warszawa, którą mamy w naszym kontenerze podglądu. 

Wróćmy więc do zakładki Start i zmieńmy widok dla tej drugiej zakładki na `DestinationsListView`. 

```swift
                DestinationsListView()
                    .tabItem {
                        Label("Destinations", systemImage: "globe.desk")
                    }
```

Teraz, gdy dotknę zakładki tej drugiej zakładki, zobaczysz, że dostawca podglądu nie został znaleziony, a to dlatego, że ten widok nie ma pojęcia, co to jest. 

![image-20240120123134638](image-20240120123134638.png)

Widzimy, więc `ContentUnavailableView`. Możemy to rozwiązać, stosując ten sam modyfikator kontenera modelu do karty Start w jej dostawcy podglądu. 

```swift
#Preview {
    StartTab().modelContainer(Destination.preview)
}
```

Wracając do `DestinationsListView`, chcę mieć przycisk na pasku narzędzi nawigacyjnych, aby utworzyć nowe miejsce docelowe. Zamierzam więc osadzić klauzulę if-else wewnątrz stosu nawigacji. Będę również chciał dodać pasek narzędzi wokół obu tych widoków, ale nie mogę tego zrobić w klauzuli if-else, więc osadzę go w grupie. Następnie mogę dodać mój tytuł, tytuł nawigacji, używając ciągu "Moje cele podróży". 

```swift
        NavigationStack {
            Group{
                if !destinations.isEmpty {
                    Text("Dane")
                } else {
                    ContentUnavailableView(...}
                }
            }
            .navigationTitle("My Destinations")
        }
```

"Następnie dodam pasek narzędzi. Ten pasek narzędzi będzie miał tylko jeden przycisk, więc nie potrzebuję elementu paska narzędzi. Mogę po prostu określić przycisk z etykietą, która będzie tym obrazem, którego użyłem w moim ContentUnavailableView. Jest to obraz używający nazwy systemowej plus ... wypełnienie. 

```swift
            .toolbar {
                Button{

                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
```

Całość daje nam szkielet widoku z lista rekordów z bazy:

```swift
        NavigationStack {
            Group{
                if !destinations.isEmpty {
                    List(destinations) { destination in
                        HStack{
                            Image(systemName: "globe")
                                .imageScale(.large)
                                //.foregroundStyle(.accent)
                            VStack(alignment: .leading) {
                                Text(destination.name)
                            }
                        }
                    }
                } else {
                    ContentUnavailableView("No Destinations", systemImage: "globe.desk", description: Text("You have not se up any destinations yet. Tap on the \(Image(systemName: "plus.circle.fill")) button in the toolbar to begin"))
                }
            }
            .navigationTitle("My Destinations")
            .toolbar {
                Button{

                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
```





Zastąpmy więc TextView z powrotem w naszym ciele listą, która iteruje po tablicy Destinations. A to da nam miejsce docelowe, którego możemy użyć do wyświetlenia. Wewnątrz listy utworzę HStack. Jako pierwszy element utworzę obraz o nazwie systemowej "globe". Ustawię skalę obrazu na dużą i zastosuję styl pierwszego planu "akcent". "Jako drugi element utworzę VStack. Jako pierwszy element w VStack wyświetlę TextView wyświetlający nazwę miejsca docelowego. A następnie poniżej, chcę wyświetlić kolejny TextView wyświetlający liczbę znaczników miejsca docelowego przy użyciu interpolacji ciągów znaków, a następnie lokalizacje ciągów znaków. Czcionkę ustawię na "caption", a styl pierwszego planu na "secondary". "Cóż, jest całkiem nieźle, ale możemy pójść o krok dalej. 

```swift
Text("\(destination.placemarks.count) location")
.font(.caption)
.foregroundStyle(.secondary)
```

Co by było, gdyby istniała tylko jedna lokalizacja, pojedyncza? Nasze lokalizacje to stały ciąg znaków w liczbie mnogiej. Cóż, tak się składa, że w Swifcie istnieje sposób, aby to dla nas określić i automatycznie zmienić formę mnogą na pojedynczą naszych słów. Możemy to zrobić zaraz po pierwszym cudzysłowie, wpisując karetkę, a następnie lewy nawias kwadratowy. Następnie mogę usunąć "s" z lokalizacji i zamknąć je prawym nawiasem kwadratowym. A oto klucz. Dodaję w nawiasie "inflect true". "Wszystko to w ramach cytatu. 

```swift
Text("^[\(destination.placemarks.count) location](inflect: true)")
.font(.caption)
.foregroundStyle(.secondary)
```

Widzimy teraz, że ponownie pokazujemy liczbę mnogą, mimo że lokalizacja jest tylko w liczbie pojedynczej w moim ciągu. Jeśli wrócę teraz do zakładki Start, zobaczę, że lista pojawia się również tutaj. 

Uruchommy apliakcje na symulatorze.  Po uruchomieniu i przejściu do zakładki Miejsca docelowe, ponieważ nie używamy naszego kontenera podglądu, nie może jeszcze znaleźć żadnych lokalizacji i widzę widok niedostępnej zawartości. 

Cóż, nadal musimy mieć możliwość tworzenia i potencjalnego usuwania miejsc docelowych znajdujących się na tej liście. A ponieważ miejsce docelowe wymaga tylko nazwy podczas tworzenia nowego widoku, użyję do tego alertu z polem wiadomości. Aby wyzwolić alert, będziemy potrzebować właściwości stanu, którą można przełączać po dotknięciu przycisku Dodaj na pasku narzędzi nawigacji. 

W tym celu utworzę nową właściwość stanu o nazwie "NewDestination" i zainicjuję ją jako "false". "

```swift
   @State private var showNewDestionationAlert = false
```

A następnie dla akcji na naszym przycisku paska narzędzi po prostu przełączę tę wartość. To pozwoli nam zaprezentować alert. Ale ten alert będzie wymagał właściwości string state dla pola tekstowego dla nazwy miejsca docelowego. 

Zamierzam więc utworzyć jedno o nazwie "DestinationName" i zainicjować je jako pusty ciąg. 

```swift
  @State private var destinationName = ""
```

Teraz, gdy przycisk zostanie naciśnięty, dołączę modyfikator alertu. Za pomocą klawisza tytułu prezentowana jest akcja i inicjalizator wiadomości. Mogę użyć ciągu "DestinationName" jako klucza tytułu i zostanie on powiązany jako "isPresented" z właściwością stanu "NewDestination". Następnie mogę nacisnąć Enter, aby utworzyć moje zamknięcia. Pierwsze zamknięcie to miejsce, w którym możemy utworzyć pole tekstowe i akcję przycisku. Tak więc w polu tekstowym użyję ciągu "EnterDestinationName" i powiążę ten ciąg z właściwością stanu "DestinationName", którą utworzyliśmy. Następnie utworzę przycisk z etykietą "OK". Ale w przypadku akcji chcę wykonać akcję tylko wtedy, gdy nazwa miejsca docelowego jest pusta. Nie chcę żadnych pustych nazw miejsc docelowych. Zapobiegnie to pustym wpisom. Następnie możemy utworzyć nowe miejsce docelowe jako obiekt docelowy, używając "DestinationName" jako właściwości name. Teraz, aby utworzyć nowe miejsce docelowe, będziemy potrzebować dostępu do kontekstu modelu kontenerów SwiftData. Cóż, to proste. W SwiftData jest on wstrzykiwany do środowiska. Wszystko, co musimy zrobić, to go pobrać. Na górze utworzę nową zmienną środowiskową dla kontekstu modelu ścieżki klucza i przypiszę ją do prywatnej zmiennej o tej samej nazwie. Następnie, gdy mamy już miejsce docelowe, możemy użyć kontekstu modelu, aby wstawić miejsce docelowe. Następnie możemy ustawić ciąg "DestinationName" z powrotem na pusty ciąg. Następnym razem, gdy alert zostanie wyświetlony, nie będzie miał tego nazwiska. Następnie podążę za tym z innym przyciskiem, który będzie etykietą "Anuluj" na wypadek, gdybym zmienił zdanie, z rolą "Anuluj". "Ale nie ma potrzeby wykonywania akcji. Spowoduje to po prostu odrzucenie alertu. A następnie dla wiadomości po prostu utworzę pole tekstowe za pomocą ciągu "Utwórz nowe miejsce docelowe". "Możesz to teraz przetestować w podglądzie. Jak widać, można utworzyć nowe miejsce docelowe, ale będzie ono tylko w pamięci. Aby usunąć miejsce docelowe, chcę użyć akcji machnięcia na elemencie na liście. W HDAC utworzę więc akcję przeciągnięcia i określę krawędź końcową. Następnie dla akcji użyjemy przycisku z rolą "Destructive". W przypadku etykiety utworzę kolejną etykietę, używając tytułu ciągu "Usuń" i obrazu systemowego "Kosz". "A następnie dla akcji możemy uzyskać dostęp do funkcji usuwania kontekstu modelu, przekazując to miejsce docelowe. Ostatnią częścią dzisiejszego dnia jest skonfigurowanie nawigacji z widoku listy do naszej mapy miejsc docelowych. A kiedy już tam będziemy, pozwolę sobie edytować nazwę i ustawić konkretny region dla miejsca docelowego. Aby to zrobić, w widoku listy miejsc docelowych musimy użyć zawartości naszego wiersza listy jako linku nawigacyjnego, który przeniesie nas do tego widoku i przejdzie do określonego miejsca docelowego. Ale najpierw zacznijmy od ostatecznego widoku docelowego. Musimy więc wprowadzić tutaj pewne zmiany w stosunku do poprzedniego filmu. Nie będziemy pobierać wszystkich miejsc docelowych dla tego widoku, aby znaleźć określone miejsce docelowe. Zamiast tego będziemy przekazywać je z naszego linku. Mogę więc usunąć zapytanie. A ponieważ miejsce docelowe zostanie przekazane, nie będzie ono własnością prywatną stanu ani nie będzie opcjonalne. Usuniemy więc @State private i znak zapytania. Następnie mogę usunąć warunek if let w konstruktorze zawartości mapy, ponieważ miejsce docelowe nie jest już opcjonalne. W bloku on a peer mamy już nasze miejsce docelowe. Mogę więc to usunąć i nie jest to już opcjonalne. Mogę więc usunąć znak zapytania. Tak więc pozycja kamery zostanie ustawiona przez region określony przez nasze miejsce docelowe. Makro podglądu wymaga wyświetlenia miejsca docelowego. Musimy więc w jakiś sposób pobrać je z naszego kontenera podglądu. Najpierw więc usunę modyfikator kontenera modelu dołączony do tego makra podglądu. Dodajmy argument dla miejsca docelowego i przejdźmy do tworzenia lub znajdowania sposobu jego uzyskania. Możemy więc utworzyć właściwość o nazwie container, która będzie naszym docelowym kontenerem podglądu. Teraz nie możemy wykonać zapytania w naszym podglądzie, ale możemy użyć metody pobierania kontenerów, aby pobrać nasze miejsce docelowe Warszawa z kontenera podglądu. Możemy więc utworzyć deskryptor pobierania, aby pobrać wszystkie miejsca docelowe. Spowoduje to pobranie tego samego, co zapytanie, tylko że nie będzie to obserwowalne. Ale to w porządku, ponieważ wyświetlamy statyczny podgląd. A następnie, aby uzyskać pierwsze miejsce docelowe, możemy utworzyć miejsce docelowe, a następnie użyć wymuszonej próby użycia metody pobierania głównego kontekstu kontenerów, przekazując deskryptor pobierania, który pobierze je wszystkie. A ponieważ wiemy, że mamy jeden Warszawa na początkowej pozycji, jest to zerowy iterator tablicy. Następnie musimy zwrócić widok mapy lokalizacji docelowej z tym miejscem docelowym. Tak więc miejsce docelowe na mapie powinno być teraz wyśrodkowane wokół Paryża, wyświetlając te znaczniki tak jak poprzednio. Teraz, ponieważ dotrzemy tutaj za pomocą stosu nawigacji, powinniśmy osadzić widok mapy lokalizacji docelowych w stosie nawigacji w podglądzie, abyśmy mogli przypisać tytuł i zobaczyć, jak wygląda w podglądzie. Pozwól więc, że utworzę teraz nowy tytuł, a także ustawię tryb wyświetlania na wbudowany. Zrobię to przed funkcją onMapChange. Tytuł nawigacji to miejsce docelowe i ustawię tryb inline. Teraz, gdy po raz pierwszy dotrę do tego widoku po utworzeniu nowego miejsca docelowego, domyślny region automatyczny zostanie ustawiony, ponieważ obecnie jest zerowy. Chcę więc dostosować go tutaj, aby upewnić się, że zostanie zapisany. Mogę również chcieć zmienić nazwę mojego miejsca docelowego na wypadek, gdybym przeliterował ją niepoprawnie. Nad mapą utwórz VStack i ustaw padding na poziomy, aby przyciągnąć go z boków. Dla pierwszego elementu VStack utwórz widok zawartości z etykietą, używając inicjalizatora etykiety zawartości. W przypadku etykiety wystarczy użyć widoku tekstowego z nazwą ciągu znaków. Zawartość to miejsce, w którym utworzymy nasz widok tekstowy, a jako klucza tytułu użyjemy ciągu "Enter Destination Name". "Musi on być powiązany z nazwą miejsca docelowego, którą przekazujemy. Problem polega na tym, że musi to być powiązanie. Cóż, na szczęście dla nas, nasz model danych Swift jest obserwowany, ponieważ pochodzi z zapytania w ostatnim widoku. Ale aby użyć znaku dolara do powiązania go, aby nasz kod o tym wiedział, musimy zrobić jeszcze jedną rzecz. Jako pierwszy wpis w treści, utwórz zmienną wiążącą dla miejsca docelowego i przypisz ją do tej, którą przekazaliśmy. Tak więc nasze pole tekstowe będzie używać tej wersji. Następnie możemy ustawić styl pola tekstowego na zaokrąglone obramowanie i styl pierwszego planu na podstawowy. Dla drugiego elementu w VStack utwórz HStack. A dla pierwszego elementu HStack utwórz widok tekstowy, aby poinformować użytkownika, jak dostosować region. Następnie ustaw styl pierwszego planu na drugorzędny. Utwórz element dystansowy, aby przesunąć go w lewo, gdzie możemy utworzyć przycisk po prawej stronie. Ustawimy etykietę przycisku na "Ustaw region". "W przypadku akcji będziemy musieli użyć instrukcji if-let, aby sprawdzić, czy widoczny region został ustawiony, a tak będzie, ponieważ to robimy. Następnie możemy zaktualizować szerokość i długość geograficzną naszego miejsca docelowego do szerokości i długości geograficznej środka widocznego regionu. Następnie możemy zrobić dokładnie to samo dla wartości delta rozpiętości dla naszego miejsca docelowego, przypisując wartości delta rozpiętości widocznego regionu. Następnie możemy zastosować styl przycisku z widocznymi obramowaniami. Jesteśmy prawie na miejscu. Ostatnią rzeczą, którą musimy zrobić, jest powrót do widoku listy naszego miejsca docelowego i skonfigurowanie naszej nawigacji, ponieważ jeszcze tego nie zrobiliśmy. Zrobimy to, tworząc nową właściwość stanu o nazwie "path", która jest typu "NavigationPath". "Możemy więc dodać ją jako powiązany argument do stosu nawigacji. HStack zawartości listy stanie się łączem nawigacyjnym. Otoczymy więc cały HStack linkiem nawigacyjnym, którego wartością będzie miejsce docelowe. Teraz musimy ustawić stos nawigacyjny dla tego miejsca docelowego. Tak więc, dołączając do listy, możemy użyć metody docelowej nawigacji dla typu "destination. self. " A to zapewni nam miejsce docelowe, które możemy przekazać do widoku mapy naszej lokalizacji docelowej. Możesz to teraz przetestować w podglądzie. Jeśli dotkniesz Paryża, zostaniesz przeniesiony do miejsca docelowego w Paryżu i zobaczysz, że region jest ustawiony i widzisz znaczniki miejsca. Mogę edytować nazwę i zmienić region. Pozwolę sobie trochę namieszać i ustawić region. Po powrocie zobaczę, że nazwa została zmieniona na mojej liście. Jeśli ponownie dotknę tego wiersza, zobaczę, że region również się zmienił. Miałem na myśli ten region, w którym tak naprawdę nie chcę być. Jest jednak jeszcze jedna rzecz, którą chcę zrobić: kiedy tworzę nowe miejsce docelowe, chcę od razu zostać przeniesiony do mapy tego miejsca docelowego, aby móc zaktualizować region. Tak więc, w akcji dla przycisku OK, po zresetowaniu nazwy do pustego ciągu, zamierzam dołączyć nowe miejsce docelowe do ścieżki, zmuszając je do wepchnięcia na stos i przeniesienia mnie do widoku tego miejsca docelowego. Przetestujmy to, tworząc nowe miasto. Wypróbuję Berlin. Jak widać, jestem przenoszony bezpośrednio do następnego widoku z domyślnym widokiem mapy. Powiększmy więc widok Berlina. Wystarczy, że kliknę dwukrotnie na mapie i będę drążyć w dół, aż znajdę obszar Berlina, który chcę odwiedzić. Następnie mogę dotknąć i ustawić region. Kiedy wrócę do widoku listy i dotknę Paryża, otrzymam region Paryża. I już tam nawigowałem. Idealnie. Jeśli wrócę, ale tym razem dotknę Berlina, zostanę przeniesiony do Berlina i czeka na nas utworzenie nowych lokalizacji. O tym w następnym filmie. W następnym filmie dowiemy się, w jaki sposób możemy ułatwić wyszukiwanie w widoku miejsca docelowego i znaleźć interesujące nas lokalizacje do ustawienia jako znaczniki. Jeśli podoba Ci się ta seria, daj kciuka w górę i zostaw komentarz. A jeśli ta seria nie została jeszcze ukończona, zasubskrybuj mój kanał, aby otrzymywać powiadomienia o nowych filmach. W przeciwnym razie kontynuuj serię, sprawdzając następny film na liście odtwarzania. [BLANK_AUDIO]

## Film 4 MapKit i SwiftUI - MapManager i wyszukiwanie

 https://youtu.be/SNni__HWoTI?si=3l0fsFBeZacA3vTq



Możesz zobaczyć, że uruchomiłem już nową gałąź dla tego filmu, a ukończony kod źródłowy tego filmu będzie w tej gałęzi. Linki do obu znajdują się w opisie. Cóż, teraz, gdy możemy utworzyć wiele miejsc docelowych i ustawić regiony, chcemy zaimplementować sposób wyszukiwania znaczników w różnych lokalizacjach, a następnie ostatecznie utrwalić je w naszej bazie danych. Interfejs API map daje nam możliwość wyszukiwania w języku naturalnym, które wyszukuje to, czego szukamy w określonym regionie, zwykle w naszym widocznym regionie. Chcę tego użyć w naszym widoku mapy miejsc docelowych, a także w widoku mapy podróży, nad którym będziemy pracować w przyszłym filmie. Kiedy jestem w jednym z tych widoków, chcę mieć możliwość wyszukiwania atrakcji, kawiarni, sklepów, stacji benzynowych itp. Wszystko to można osiągnąć za pomocą zapytania w języku naturalnym, a następnie dodać te znaczniki miejsca do mojego widoku obok tych, które już wybrałem dla tego miejsca docelowego. Cóż, sposób, w jaki zamierzam obsłużyć to wyszukiwanie, polega na tymczasowym dodaniu wszystkich wyników wyszukiwania do mojej pustej tabeli znaczników miejsc w naszej bazie danych, ale pozostawieniu miejsca docelowego jako zerowego. Pozwoli mi to na łatwe usunięcie ich wszystkich, gdy odejdę od widoku i pozwoli mi zaprezentować je na górze mojej mapy w innym kolorze. Ponieważ zamierzam używać tego w dwóch różnych widokach, chcę utworzyć usługę menedżera map, w której mogę utworzyć kilka statycznych funkcji, które mogę wywołać z dowolnego widoku. Zacznijmy więc od utworzenia nowego folderu, który nazwę services. Wewnątrz niego utworzę nowy plik, nie plik SwiftUI, i nazwę go map manager. Po utworzeniu pliku zmień import na map kit i dodaj kolejny dla SwiftData. Następnie tworzę enum o nazwie map manager. Używam wyliczenia zamiast struktury, klasy lub singletonu, ponieważ chcę użyć go jako przestrzeni nazw i po prostu chcę utworzyć tutaj trzy funkcje statyczne. Pierwszą z dwóch utworzę teraz. Podczas wyszukiwania musimy znać wyszukiwany ciąg, widoczny region, a ponieważ będziemy używać SwiftData do wstawiania tego, co znajdziemy, będziemy musieli wiedzieć, jaki jest kontekst modelu. Ale nie jesteśmy w widoku i nie możemy użyć zmiennej środowiskowej, aby ją pobrać. Będę więc musiał pobrać to z widoku, abyśmy podczas wywoływania naszych funkcji musieli przekazać to do funkcji jako argument. Utwórzmy więc teraz tę funkcję i będzie to funkcja statyczna, którą będę wywoływać w miejscach wyszukiwania z tymi trzema parametrami. Pierwszym będzie kontekst modelu typu kontekst modelu i używam tego podkreślenia na początku, aby wywołujący nie musiał używać etykiety jako argumentu. W drugim nazwiemy go tekstem wyszukiwania i będzie to ciąg znaków. Trzeci będzie naszym widocznym regionem, który jest opcjonalnym regionem współrzędnych MK. 



Teraz ta funkcja wykona wywołanie asynchroniczne, więc musi być oznaczona jako asynchroniczna. Teraz w treści funkcji najpierw utworzymy żądanie, które jest funkcją żądania wyszukiwania lokalnego MK. Określimy, że właściwość zapytania w języku naturalnym będzie tekstem wyszukiwania. Następnie możemy użyć instrukcji if, aby rozwinąć widoczny region i przypisać go do regionu żądania. Zamierzam utworzyć właściwość o nazwie search items, która będzie opcjonalną odpowiedzią z żądania wyszukiwania, a można to zrobić za pomocą opcjonalnego try i wait dla lokalnego wyszukiwania MK przy użyciu żądania, a następnie wykonać funkcję start. Następnie możemy zmapować elementy wyszukiwania do tablicy o nazwie results. A ponieważ jest to opcjonalne, nie chcemy, aby było opcjonalne, przypiszemy pustą tablicę bez koalescencji. Teraz, jeśli opcjonalnie klikniesz na wyniki, zobaczysz, że jest to tablica elementów mapy, którą możemy drążyć i widzimy tutaj, że zawiera ona tak zwany znak miejsca. Chciałbym więc użyć pętli for each na tablicy, a następnie utworzyć pusty placemark z wygenerowanego iteratora. Zamierzam więc użyć tutaj notacji skrótowej i użyć dolara zero zamiast przypisywania zmiennej dla tego elementu mapy MK, aby uzyskać dostęp do jego właściwości placemark. Utwórzmy więc pusty placemark za pomocą inicjalizatora i użyję kontrolki m, aby oddzielić każdy argument w osobnej linii, a następnie dla nazwy możemy użyć dolara zero iteratorów placemark dot name, ale jest to opcjonalne, więc nie możemy połączyć tego w pusty ciąg. Dla adresu nie ma właściwości adresowej placemark, ale możemy ją znaleźć we właściwości title. To również jest opcjonalne, więc będziemy musieli podać pusty ciąg znaków. Aby znaleźć szerokość geograficzną, musimy uzyskać dostęp do współrzędnych placemarks, a następnie wybrać szerokość geograficzną. Podobnie postępujemy w przypadku długości geograficznej. Po uzyskaniu pustego znaku miejsca możemy użyć przekazanego kontekstu modelu, który otrzymaliśmy w funkcji, aby wstawić ten pusty znak miejsca do naszej bazy danych, a SwiftData automatycznie go zapisze. Jest jeszcze jedna rzecz, którą musimy zrobić. Ta funkcja będzie aktualizować nasz interfejs użytkownika, dodając znaczniki miejsc, więc musi być uruchamiana w głównym wątku, więc będziemy musieli udekorować ją aktorem @main. Musimy więc dodać nowy placemark do głównego wątku. Zanim jednak opuścimy tę usługę, chcę utworzyć jeszcze jedną funkcję. Gdy wykonujemy nowe wyszukiwanie lub gdy nasz widok znika, chcemy mieć możliwość usunięcia wszystkich wyników wyszukiwania, których nie dodaliśmy do określonej lokalizacji.



 Zajmiemy się tym w następnym filmie. Utwórzmy więc nową właściwość statyczną o nazwie removeSearchResults, która podobnie jak funkcja wyszukiwania miejsc musi mieć kontekst modelu jako parametr. Aby usunąć wszystkie znaki miejsc, w których nie ma lokalizacji, musimy tylko znaleźć te, w których miejsce docelowe jest zerowe. Możemy to zrobić w SwiftData za pomocą makra predykatu. Tak więc nasz predykat wyszukiwania będzie równy predykatowi dla znaczników miejsc, w których przy użyciu $0 miejsce docelowe jest równe zeru. Będą to tylko te wyszukiwania. A następnie możemy użyć opcjonalnego try, aby wywołać funkcję usuwania kontekstu modelu, aby usunąć wszystkie elementy w modelu empty placemark.self, w których obowiązuje ten predykat wyszukiwania. Będziemy również chcieli upewnić się, że jeśli wykonujemy sekwencyjne wyszukiwanie w naszym widoku bez odchodzenia od widoku za każdym razem, gdy wykonujemy nowe wyszukiwanie, poprzednie wyniki wyszukiwania są usuwane. Tak więc jako pierwszą linię przed utworzeniem naszego żądania wywołamy tę funkcję również w tej pierwszej funkcji. Teraz, gdy mamy już utworzone nasze funkcje, możemy uzyskać do nich dostęp z widoku mapy lokalizacji docelowych. Tak więc dla pola tekstowego wyszukiwania będziemy potrzebować właściwości stanu. Utworzymy ją więc jako tekst wyszukiwania i zainicjujemy jako pusty ciąg znaków. Ale zamierzam również dodać stan fokusu, aby móc go użyć do odrzucenia klawiatury po dotknięciu przycisku. Stwórzmy więc ten stan fokusu jako fokus pola wyszukiwania i ustawmy go jako wartość logiczną. Teraz gdzie umieścić pole wyszukiwania. Cóż, zdecyduję się umieścić je w dolnej wstawce bezpiecznego obszaru. Tak więc po widoku mapy utwórz wstawkę bezpiecznego obszaru z krawędzią na dole. Wewnątrz niego utwórz stos h i dodaj trochę wypełnienia dookoła. Jako pierwszy element w stosie h utwórz pole tekstowe z kluczem tytułowym search, po którym następują trzy kropki, i za pomocą właściwości text powiąż je z właściwością search text state. Następnie ustaw styl pola tekstowego na zaokrąglone obramowanie. I tutaj możemy ustawić fokus na powiązany fokus pola wyszukiwania. Oznacza to, że po dotknięciu tego pola fokus pola wyszukiwania zostanie ustawiony na wartość true i pojawi się klawiatura. Aby odrzucić klawiaturę, możemy utworzyć przycisk nakładki, który pojawia się, gdy pole jest skupione, a po dotknięciu odrzuca klawiaturę, ustawiając stan fokusu z powrotem na wartość false. Utwórz więc nakładkę z wyrównaniem trailing. Następnie w treści możemy zobaczyć, czy fokus pola wyszukiwania jest prawdziwy, utworzymy przycisk. Użyjemy etykiety z nazwą systemu i wypełnieniem dot circle dot. Zastosuję przesunięcie, gdzie x jest równe minus pięć, aby przesunąć go z prawej strony. Początkowo, ponieważ to pole wyszukiwania nie ma fokusu, nie ma przycisku, ale po dotknięciu pola pojawia się przycisk. Aby stracić fokus po dotknięciu przycisku, musimy ustawić tekst wyszukiwania z powrotem na pusty ciąg. A następnie ustawić fokus pola wyszukiwania na wartość false. W ten sposób, gdy klawiatura zostanie zaprezentowana tak, jak w symulatorze lub na urządzeniu, zostanie odrzucona. Teraz do tego pola tekstowego możemy dołączyć przycisk. Teraz do tego pola tekstowego możemy zastosować metodę on submit. W tej metodzie chcemy wywołać funkcję wyszukiwania miejsc naszych menedżerów map. Ale ponieważ jest to funkcja asynchroniczna, będziemy musieli utworzyć jednostkę pracy zadania. 



Będziemy jednak musieli przekazać kontekst modelu do tej konkretnej funkcji, ale jeszcze go nie mamy. Więc na górze widoku pobierzmy go ze środowiska. Tworzymy więc zmienną środowiskową dla kluczowej ścieżki model context i przypiszemy ją do naszej własnej właściwości o nazwie model context. Następnie z powrotem w tym zadaniu możemy oczekiwać na wyniki wywołania funkcji wyszukiwania miejsc menedżera. Ponownie użyję kontrolki m, aby rozdzielić argumenty na ich własne linie. Następnie przekażemy nasz kontekst modelu, tekst wyszukiwania i widoczne regiony dla odpowiednich argumentów. Po zakończeniu wyszukiwania i zwróceniu wyników możemy wyczyścić tekst wyszukiwania, ustawiając go na pusty ciąg. Jak wyświetlić znalezione znaczniki miejsc po zakończeniu wyszukiwania? Cóż, możemy utworzyć zapytanie danych Swift, aby pobrać wszystkie te puste znaczniki miejsc, które zostały dodane i nie mają miejsca docelowego. W górnej części widoku utwórz to zapytanie, ale dodaj do niego filtr za pomocą makra predykatu. Predykat ten będzie oparty na pustych znacznikach miejsc. A następnie warunek jest wtedy, gdy miejsce docelowe naszego iteratora $0 jest równe zeru. Przypiszemy to do zmiennej, którą nazwiemy search place marks, która jest tablicą pustych znaczników miejsc. Cóż, stwórzmy więc kolejną obliczoną właściwość, która połączy zarówno nasze docelowe znaczniki miejsc, jak i ten zestaw wyszukiwanych znaczników miejsc. Nazwiemy więc tę prywatną właściwość list place marks, która jest tablicą pustych znaczników miejsc. Dodamy do niej sumę znaczników miejsca wyszukiwania i miejsca docelowego. Teraz musimy zmienić listę, aby zamiast tego iterować przez listę znaczników miejsc. Chcemy jednak rozróżnić te dwa zestawy. Chcemy więc przedstawić istniejący zestaw tylko wtedy, gdy miejsce docelowe znaczników miejsca nie jest zerowe, co oznacza, że już przypisaliśmy lokalizację. Jeśli jest zerowa, to w innym przypadku możemy po prostu użyć ogólnego znacznika, używając nazwy znacznika miejsca jako klucza tytułu i obliczonej właściwości współrzędnych znacznika miejsca dla współrzędnych. Jeśli teraz dotkniemy tego pola i spróbujemy przeprowadzić wyszukiwanie, nasz podgląd ulegnie awarii. A to dlatego, że dodaliśmy zapytanie z powrotem do tego widoku i będziemy chcieli, aby podgląd działał dla nas. Musimy zastosować kontener modelu dla podglądu kropki docelowej. Przetestujmy to teraz i wyszukajmy coś takiego jak atrakcje. Spowoduje to wyświetlenie wszystkich tych atrakcji w widoku. Jeśli ponownie wyszukam, powiedzmy, kawiarnie, istniejący zestaw zniknie i pojawi się nasz nowy zestaw. Chcę mieć możliwość wyczyszczenia wszystkich tych czerwonych znaczników, jeśli nawet nie wykonam kolejnego wyszukiwania. Zanim zakończymy ten film, zrobię jeszcze jedną rzecz, a mianowicie utworzę przycisk usuwania. Dlatego właśnie utworzyłem stos h, aby wyświetlić to pole tekstowe. Jako drugi element utworzę drugi widok, który jest przyciskiem, który pojawia się tylko wtedy, gdy tablica znaków wyszukiwania nie jest pusta. Jeśli nie jest pusta, utworzę przycisk z etykietą będącą obrazem z nazwą systemu map pin dot slash dot circle dot fill.

 Następnie ustawię skalę obrazu na dużą. A następnie dla samego przycisku zastosuję biały styl pierwszego planu. Dodam ośmiokrotne wypełnienie. Ustaw tło na czerwone. A następnie zastosuj kształt klipu koła. Możemy to teraz przetestować. Początkowo przycisk nie pojawia się, ale gdy tylko zakończymy wyszukiwanie, zobaczysz, że przycisk się pojawi. Aby wyczyścić znaczniki miejsc wyszukiwania, musimy przekazać wywołanie do menedżerów map, aby usunąć funkcję wyników wyszukiwania w akcji i przekazać ten kontekst modelu. Teraz za każdym razem, gdy wykonujemy wyszukiwanie, wszystkie znaczniki wyszukiwania są wyświetlane, a następnie dotknięcie przycisku spowoduje ich usunięcie. Ostatnia rzecz, o której wspomniałem wcześniej, gdy widok zniknie, chcemy usunąć wszelkie znaczniki miejsc, aby nie były prezentowane w naszym pierwszym widoku, nad którym wkrótce będziemy pracować. Jeśli więc chcemy usunąć wszelkie znaczniki miejsca, musimy utworzyć nowy widok. I to jest pierwszy widok, nad którym będziemy wkrótce pracować. Utwórz więc blok on disappear. W tym miejscu wywołamy funkcję menedżerów map usuwającą wyniki wyszukiwania, przekazując kontekst modelu. A skoro już przy tym jesteśmy, myśląc z wyprzedzeniem, że możemy mieć wyszukiwanie w naszym pierwszym widoku, a następnie przejść bezpośrednio do tego widoku, więc będziemy chcieli upewnić się, że po uruchomieniu tego widoku usuniemy wszelkie znaczniki miejsc, które poprzednio już miałeś. Tak więc w bloku on appear wykonajmy kolejne wywołanie tej funkcji. W następnym filmie dowiemy się, jak możemy zaprezentować modalny arkusz wyświetlający informacje o znaczniku miejsca i dodać go do naszej listy miejsc docelowych. Da nam to również możliwość rozejrzenia się, jeśli takie miejsce jest dostępne. Dowiemy się również, jak po dodaniu znacznika miejsca do lokalizacji możemy go usunąć i ewentualnie edytować nazwę i adres. Jeśli podoba Ci się ta seria, daj temu filmowi kciuka w górę i zostaw mi komentarz. A jeśli ta seria nie została jeszcze ukończona, zasubskrybuj mój kanał, aby otrzymywać powiadomienia o nowych filmach. W przeciwnym razie kontynuuj serię, sprawdzając następną na liście odtwarzania. [BLANK_AUDIO]

## Film 5 



Teraz, zanim zacznę od głównego tematu dzisiejszego filmu, chcę wprowadzić kilka drobnych zmian, które poprawią wrażenia użytkownika. 

Gdy dodajemy nowe miejsce docelowe, stukamy w pole tekstowe w widoku listy miejsc docelowych. Chcę wyłączyć automatyczną korektę i mogę to zrobić za pomocą jednego modyfikatora widoku, którym jest Auto-Correction Disabled. 

Następnie w akcji przycisków OK chcę przyciąć wszelkie puste białe spacje przed lub po. Wszystko, co muszę zrobić, to podać nazwę miejsca docelowego, w którym przycinamy znaki w białych spacjach i nowych wierszach. Jeśli otworzę teraz widok mapy Lokalizacje docelowe, chcę wyłączyć automatyczną korektę w polu wyszukiwania, a także wyłączyć automatyczną kapitalizację. Tak więc w polu tekstowym, po ustawieniu stylu, ustawię wyłączoną autokorektę, a następnie ustawię automatyczną kapitalizację tekstu na Nigdy. 

Następnie użyjemy tych modyfikatorów w następnym widoku, który również chcę utworzyć. Najpierw jednak potrzebuję sposobu, aby wybrać znacznik i wiedzieć, do którego znacznika pustego miejsca się odnosi. 

Ale jest jeszcze jedna rzecz, którą chcę naprawić. Po przeprowadzeniu wyszukiwania na ekranie chcemy, aby widoczny obszar był skupiony wokół wyników wyszukiwania. W funkcji On Submit, po ustawieniu tekstu wyszukiwania z powrotem na pusty ciąg znaków, ustaw pozycję kamery na Automatic. Po wybraniu znacznika chcemy przechowywać powiązany znacznik miejsca we właściwości stanu, która uruchomi arkusz modalny, aby wyświetlić więcej informacji o tym znaczniku. 

Utworzymy właściwość stanu o nazwie `SelectedPlaceMark` i będzie to opcjonalny pusty znacznik miejsca, ponieważ żaden nie zostanie wybrany podczas ładowania widoku. Następnie możemy dodać argument wyboru do naszego widoku mapy, który jest powiązany z tą nową właściwością stanu. Ale kiedy dotkniemy jednego z naszych znaczników, chcemy, aby ten wybór został ustawiony na odpowiadający mu pusty znacznik miejsca. 

I to jest cała ta sekcja, w której mamy klauzulę If Else, więc musimy najpierw zawrzeć ją w grupie, a następnie możemy zastosować znacznik, który ustawia znacznik miejsca po wybraniu. Teraz, jeśli wybierzesz jeden ze znaczników, rozszerzy się on, abyśmy wiedzieli, że został wybrany. Stuknięcie innego znacznika spowoduje jego rozwinięcie. Jeśli stukniesz gdzieś poza ekranem lub poza znacznikiem miejsca, znacznik miejsca powróci do zera, a znacznik zmniejszy się z powrotem. Ale to, co chcemy zrobić, to zaprezentować modalny arkusz, gdy znacznik jest zaznaczony, abyśmy mogli uruchomić ten arkusz w oparciu o opcjonalny `SelectedPlaceMark`, ponieważ jest to identyfikowalny obiekt. Więc dołączymy to do mapy, gdzie mamy arkusz, w którym element jest powiązany z `SelectedPlaceMark`, a to da nam `SelectedPlaceMark`, którego możemy użyć do prezentacji naszego widoku. 

Teraz zamierzam utworzyć do tego konkretny widok, ale dla testu zobaczmy, czy możemy zaprezentować nazwę znacznika miejsca w widoku tekstowym. Ustawię tutaj PresentationDetents, to tablica, na po prostu jedną, gdzie jest wysokość, gdzie określę wysokość 450, aby nie zajmowała całego ekranu. Jeśli teraz przetestuję, zobaczę, że zawartość wyświetla się idealnie. Pozwól, że najpierw przeprowadzę wyszukiwanie, aby wyświetlić niektóre z tych czerwonych znaczników miejsca. Jeśli dotknę jednego z nich, zostanie on wyświetlony. To świetnie, ja też to widzę. Następnie musimy utworzyć widok, który będzie używany zamiast tego pojedynczego widoku tekstowego. W tym widoku będziemy mogli zaktualizować właściwości nazwy i adresu, jeśli wybraliśmy żółty znacznik, który jest już w naszej bazie danych, lub być może chcemy go usunąć z kolekcji. Ale będziemy również chcieli mieć możliwość, jeśli wybierzemy czerwony znacznik, być może zmienić nazwę i adres i dodać go do wyboru dla naszego miejsca docelowego. Oznacza to, że będziemy musieli przekazać w naszych nowych widokach dwie właściwości, wybrany znacznik miejsca i miejsce docelowe. Widok prezentujący informacje będzie współdzielony przez widok miejsca docelowego oraz pierwszy widok, którego jeszcze nie zakodowaliśmy. Utworzę więc nową grupę i nazwę ją "Shared Views". Wewnątrz niej utworzę nowy widok SwiftUI i nazwę go "Location Detail View". Będę musiał zaimportować MapKit, a także SwiftData. A ponieważ będzie to prezentowane jako arkusz modalny, chcę mieć możliwość utworzenia przycisku, który odrzuci arkusz. Zamierzam więc utworzyć zmienną środowiskową, aby uzyskać dostęp do funkcji zwalniania, dzięki czemu będę mógł wywołać tę funkcję "Dismiss Function". Następnie utworzymy dwie właściwości, które zostaną przekazane z poprzedniego widoku, jedną dla miejsca docelowego i jedną dla wybranego znacznika miejsca. Obie te właściwości będą opcjonalne, ponieważ, jak już wspomniałem, będziemy ich używać w naszym pierwszym widoku mapy, który będzie wyświetlał naszą bieżącą lokalizację, a cel podróży nie będzie znany. Oba będą więc opcjonalne. Miejsce docelowe, które jest opcjonalnym miejscem docelowym, oraz wybrany znacznik miejsca, który jest opcjonalnym pustym znacznikiem miejsca. Teraz, jeśli chcemy mieć możliwość aktualizacji właściwości nazwy i adresu naszego znacznika miejsca, będziemy musieli utworzyć w tym celu dwie właściwości stanu. Jedna dla nazwy, która jest ciągiem znaków, więc ustawimy ją jako pusty ciąg znaków, a druga dla adresu, kolejny pusty ciąg znaków. Będziemy chcieli móc zaktualizować wybrany znacznik miejsca, jeśli jedna z tych właściwości zostanie zmieniona. Zamierzam więc uczynić mój kod bardziej czytelnym, tworząc wyliczaną właściwość, którą nazwę "isChanged" i która będzie wartością logiczną. Ta wartość logiczna najpierw użyje sprawdzania strażnika, aby rozwinąć wybrany znacznik miejsca i zwrócić wartość false. Jeśli to się nie powiedzie, nie powinno się to nigdy nie udać, ale muszę to zrobić, ponieważ nie chcę rozpakowywać na siłę. Następnie możemy zwrócić przypadek, w którym nazwa nie jest równa nazwie wybranego znacznika miejsca lub adres nie jest równy adresowi wybranego znacznika miejsca. Oznacza to, że każda zmiana w którymkolwiek z tych dwóch pól, które wprowadzimy, zostanie zmieniona na true. Teraz, gdy budujemy nasz widok, jeśli chcemy zaprezentować pewne makiety danych w naszym podglądzie, będę musiał dokonać zmiany w naszym podglądzie, aby pobrać pojedynczy cel podróży i jeden z naszych znaczników miejsca. Cóż, zrobimy to samo, co zrobiliśmy w widoku mapy lokalizacji docelowej, więc otworzę ten widok, aby tam wrócić, a w makrze podglądu skopiuję te trzy wiersze. Następnie wkleję je do makra podglądu tutaj, a to pobierze lokalizację Paris naszych makiet danych, ponieważ jest tylko jedna, i możemy upewnić się, że jest ona przypisana do miejsca docelowego. Wiemy jednak, że nasza makieta danych ma tablicę znaczników miejsc, więc możemy pobrać pierwszy z nich i przypisać go do wybranej właściwości znaczników miejsc. Następnie możemy zwrócić widok szczegółów lokalizacji przy użyciu obu pobranych wartości. Zaprojektujmy więc widok. Po wyświetleniu widoku, jeśli pochodzimy z naszego widoku docelowego, będziemy chcieli przypisać wartości wybranego znacznika miejsca do właściwości nazwy i adresu. Utworzymy więc blok onAppear, a wewnątrz niego użyję instrukcji if let, aby rozpakować opcjonalny wybrany znacznik miejsca, a jednocześnie sprawdzić, czy miejsce docelowe nie jest zerowe. Jeśli tak jest, możemy przypisać właściwości selected place mark do właściwości name i address state. Teraz możemy zacząć projektować widok. W treści zastąp widok tekstowy stosem VStack, a następnie dodaj do niego wypełnienie. Wewnątrz niego utwórz HStack, a następnie dodaj element dystansowy, aby wypchnąć wszystko na górę. Następnie jako pierwszy element w HStack utwórz VStack z wyrównaniem wiodącym. W wewnętrznym VStack utwórz dwa pola tekstowe na tytuł i adres. Pierwsze pole tekstowe będzie miało ciąg znaków name i będzie powiązane z naszą właściwością name state, a czcionkę ustawię na title. Drugie pole tekstowe będzie przeznaczone na adres, powiązany z naszą właściwością stanu adresu, ale chcę ustawić oś na pionową, aby mogła się rozszerzać w przypadku dłuższych adresów. Następnie zastosuję styl zaokrąglonego obramowania pola tekstowego do całego VStack. Zauważ, że za każdym razem, gdy pojawi się widok, możesz zobaczyć inną nazwę i adres pojawiające się w widoku. Dzieje się tak, ponieważ tablica znaczników miejsc nie jest posortowana, więc za każdym razem otrzymasz losowy wybór. Poniżej chcę wyświetlić przycisk, tylko jeśli edytowaliśmy te wartości, co oznacza, że jeśli zmiana musi mieć wartość true, i chcę, aby ten przycisk miał klucz tytułu aktualizacji. Dla akcji ustawię opcjonalną nazwę wybranego znacznika miejsca na wartość nazwy stanu i przytnijmy wszelkie białe spacje z nazwy. To samo zrobię dla adresu wybranego znaku miejsca. A następnie, aby przesunąć ten przycisk do końcowej krawędzi, ustawię ramkę, w której ustawię maksymalną szerokość na nieskończoność, a wyrównanie na końcowe. I ponownie ustawię styl przycisku na obramowanie. Teraz, jako drugi element w HStack, dodam element dystansowy, a następnie utworzę przycisk z etykietą, która jest obrazem przy użyciu obrazu systemowego xmark. circle. fill. Ustawię skalę obrazu na dużą, a następnie ustawię styl pierwszego planu na szary, a następnie dla akcji wywołam funkcję dismiss. Spowoduje to odrzucenie prezentowanego arkusza modalnego. Poniżej chcę utworzyć przycisk, który pozwoli mi dodać lub usunąć znacznik miejsca z docelowego zestawu znaczników miejsca. Więc poniżej tego pierwszego HStack, utwórz kolejny, a następnie dodaj element dystansowy, aby przesunąć zawartość w prawo. Najpierw musimy sprawdzić, czy pochodzimy z naszego widoku docelowego, więc możemy użyć if let, aby go rozpakować. Następnie, aby uczynić mój kod bardziej czytelnym, utworzę obliczoną właściwość o nazwie inList i po prostu sprawdzę, czy wybrany znacznik miejsca nie jest zerowy, a jednocześnie miejsce docelowe wybranego znacznika miejsca nie jest zerowe. Oznacza to, że jesteśmy w miejscu docelowym, a wybrany znacznik miejsca został już dodany. Następnie mogę utworzyć przycisk. Etykieta będzie warunkowa na podstawie inList. Zamierzam więc utworzyć etykietę, a następnie, jeśli inList ma wartość true, będzie to usuń, w przeciwnym razie będzie to dodaj. A następnie dla etykiety mogę dodać obraz systemowy, który również jest warunkowy w oparciu o inList, i będzie to minus. okrąg, jeśli jest, i plus. okrąg, jeśli nie jest. Następnie ustawię tym razem styl przycisku na border prominent i zastosuję odcień, który jest ponownie warunkowy w oparciu o inList, więc będzie czerwony, jeśli jest, i zielony, jeśli nie jest. Zamierzam również wyłączyć przycisk w dwóch przypadkach, gdy nazwa jest pusta lub została zmieniona. W przypadku akcji możemy rozpakować wybrany znacznik miejsca za pomocą if let, a następnie, jeśli miejsce docelowe wybranego znacznika miejsca jest zerowe, możemy dołączyć go do znaczników miejsca docelowego. W przeciwnym razie możemy ustawić miejsce docelowe wybranego znacznika miejsca na nil, co spowoduje usunięcie go z zestawu, a następnie po prostu zwolnimy. Możemy więc teraz powrócić do widoku mapy miejsca docelowego, a następnie mogę zastąpić tymczasowy widok tekstowy w wywołaniu arkusza wywołaniem widoku szczegółów naszej nowej lokalizacji, a ja przekażę miejsce docelowe i wybrany znacznik miejsca. W naszym podglądzie wybierzmy znacznik, taki jak Luwr. Pozwól mi edytować nazwę, a pojawi się przycisk aktualizacji. Wygląda na to, że umieściłem go w niewłaściwej lokalizacji. Naprawię to za chwilę. W każdym razie nadal mogę go zaktualizować i zamknąć, odrzucić modal i widzę, że znacznik został zaktualizowany. Pozwól, że wybiorę go ponownie i zauważę, że przycisk pokazuje usunięcie, ponieważ jest to jeden z naszych znaczników miejsca Paris. Kliknę więc, aby go usunąć, a okno modalne wyłączy się i zobaczysz, że został on usunięty z widoku. Przeprowadźmy wyszukiwanie. Zamierzam wyszukać muzea. Wybiorę to muzeum i pojawi się widok z przyciskiem dodawania. Cóż, z jakiegoś powodu mój podgląd ulega awarii i szczerze mówiąc, w tej chwili nie wiem dlaczego. Jeśli uda mi się to rozgryźć, przedstawię aktualizację w kolejnym filmie. Nadal jednak możemy to przetestować bez uruchamiania symulatora. Mogę otworzyć widok karty początkowej i zacząć od tego miejsca, a następnie wybrać kartę miejsca docelowego, a zobaczysz znaczniki dla Paryża, a następnie wykonam kolejne wyszukiwanie muzeów i wybiorę jedno, a przycisk dodawania tam jest. Jeśli dotknę przycisku dodawania, zostanie ono dodane. Nie ma awarii. Wróćmy więc teraz do widoku szczegółów lokalizacji i przenieśmy przycisk aktualizacji do VStack, gdzie powinien się znajdować. Ostatnią rzeczą, którą chcemy zrobić, jest zapewnienie podglądu, jeśli taki istnieje, dla wybranego znacznika miejsca. Utwórzmy więc właściwość stanu o nazwie look-around scene, która będzie opcjonalną sceną podglądu MK. Jest to więc tylko scena podglądu. Następnie, poza ciałem, utworzymy nową funkcję, którą nazwę fitLookAroundPreview i która będzie wywoływana asynchronicznie, więc musimy oznaczyć ją jako asynchroniczną. Wewnątrz treści funkcji użyję instrukcji if, aby rozpakować wybrany znacznik miejsca. Następnie ustawię wszystkie poprzednie sceny, które mogliśmy mieć, na zero. Utworzę żądanie look-around ze struktury MK look-around request, przekazując współrzędną wybranego znacznika miejsca. Następnie można spróbować oczekiwać na żądanie look-around dot scene i zastosować je do właściwości state naszego look-around. Cóż, ta funkcja musi być wywoływana za każdym razem, gdy pojawia się nasz widok i jest asynchroniczna, więc moglibyśmy użyć bloku onAppear i dodać go tam, ale musielibyśmy dodać jednostkę pracy zadania. Możemy jednak połączyć zarówno onAppear, jak i jednostkę pracy z zadaniem, które określa właściwość ID, która jest pewnym sprawiedliwym obiektem, który będzie się zmieniał. Nasz widok jest inicjowany wybranym znacznikiem miejsca, który zmienia się z opcjonalnego na nieopcjonalny. Utworzymy więc to zadanie z ID powiązanym z wybranym znacznikiem miejsca, a następnie możemy oczekiwać na pobrany podgląd. Wszystko, co musimy teraz zrobić, to zaprezentować go w naszym widoku. Cóż, nie wszystkie witryny będą miały podgląd, więc możemy otrzymać zero. W takim przypadku zamierzam wyświetlić widok niedostępny. Pomiędzy dwoma HStackami użyję instrukcji if let, aby rozpakować scenę podglądu. Teraz, jeśli nie ma wartości nil, zaprezentujemy widok, w którym początkową sceną jest nasza scena. Następnie ustawię ramkę na wysokość 200 i dodam trochę wypełnienia. W przeciwnym razie musi wynosić zero, więc utworzę widok niedostępnej zawartości i podam ciąg "brak dostępnego podglądu" oraz obraz systemowy "i. /". W podglądzie powinien pojawić się albo podgląd, albo widok niedostępny. Dotknięcie przycisku podglądu na żywo w podglądzie spowoduje losowe wyświetlanie znaku miejsca, a czasami zobaczysz niedostępny widok, jeśli nie było podglądu. Wróćmy więc do widoku mapy miejsc docelowych. Mogę dotknąć dowolnego z tych znaczników i zobaczyć, że jest podgląd. Zapomniałem wspomnieć, że po dotknięciu podglądu można uzyskać pełny widok. Możesz także wyszukać lokalizację, a te, które mają podgląd, również zostaną wyświetlone. Na razie to wszystko. W następnym filmie dowiemy się, jak zamiast wyszukiwać lokalizacje, po prostu znaleźć jedną na mapie, którą chcemy i dotknąć mapy, aby ustawić znacznik. W ten sposób, jeśli wyszukiwanie umieści znacznik bez podglądu, możesz go usunąć i znaleźć lokalizację w pobliżu, która oferuje podgląd. Jeśli podoba Ci się ta seria, daj kciuka w górę i zostaw komentarz. A jeśli ta seria nie została jeszcze ukończona, zasubskrybuj mój kanał, aby otrzymywać powiadomienia o nowych filmach. W przeciwnym razie kontynuuj serię, sprawdzając następny film na liście odtwarzania.