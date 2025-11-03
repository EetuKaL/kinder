

					| IMAGES 
					| BIO   
					| encounters Map<encounted.id, ecounted-doc.id>			
USERS -- user.id -->| 
			
		

					

			
					


TYKÄTÄÄN_HENKILÖSTÄ: tykkää tai ei tykkää kirjoitetaan joka tapauksessa encounted doc ja molempien osapuolien encounters mappiin encountered tietue encountered dokuemntti:idl arvona
LIKED_ME : dynaaminen arvo, joka haetaan encounters mapista encounter dokumentit joissa vastakkainen osapuoli on tykännyt sinusta , etkä sinä ole vielä vastaustasi antanut.
MATCHES: dynaaminen arvo encounter missä molemmat tykkää toisistaan
PROFIILI EHDOTUKSET: users.where ((user) => encounters[user] == null || ecounterDocs[encounters[user]].user.id != false && ecounterDocs[encounters[user]].omaId == null)
POISTETAAN MATCH: muokataan encounters dokumenttia ja asetetaan tykkäys falseksi





			
encounter:	|chemistry {Map<String, bool>}
			|conversation list<message>
								
							 

	|message string
message:|sent date		
	|read bool
	|by string

      |matches List<Like>
user: |specs FirebaseUser (firebasen oma model)
      |bio KinderBio
	
	   |birthday: date
	   |age: int (dynamic: calculate from birdtday)
kinderBio: |aboutMe: string
	   |gender: bool? (true: male, false: female, null: somethingElse )
	   |searchGender: bool? (true: vastakkainen sukupuoli, false: omasukupuoli, null: BI)
	   |redFlags List<String>
	   |greenFlags List<String>
           |jobStatus: bool? (true: töissä, false työtön, null: en halua kertoa)
	   |jobAt: string?
	   |whatWouldIDoIfIWouldGetAMillion: string (min lengt 100) 
	   |images List<URL>h
	   |name String


Muuta aatoksia deittisovelluksesta:
- kylmät keskustelut poistetaan hetken ajankuluttua
   - EHDOTUS:
	FLÄGI SYSTEEMI:
	- jos keskustelu poistaa kylmittymisen johdosta molemmille red-flag.
	- asetetaan poisto matchille, joka avaa seuraavat vaihtoehdot matchille ennen poistoa (vältytään red flagilta):
		- hyväksy poisto
		- hyväksy poisto ja anna green flagi
		- ehdota jatkoa vielä (haluaisin sinuun tutustua)

- ei sallita hymiöitä, vähentääksmme väärin ymmärryksiä.

- live-online keskustelu-huone paikkakunnittain. (jotta tarjotaan myös: deittaiu vertaistukea/ystävyyksiä/sosiaalitilanteita) Huoneen voi tehdä kuka tahansa ja hänestä tulee samalla sen huoneen hallitsija.) 


encounterdod Map<ehdotettu profiili tai tykännyt henkilö> 
matches: map<>

EI TOIMIKKKAAN:
				

