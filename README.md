# testing-toolbox

A toolbox of handy single-file scripts to help with testing, or daily hacking.

- List of scripts
    - :hear_no_evil: [jwtDecoder.sh](#jwtDecodersh): decode JWT token
    - :link: [urlCoder.sh](#urlCodersh): encode or decode URL
    - :id: [uuidValidator.sh](#uuidValidatorsh): validate GUID/UUID
    - :scroll: [fileGenerator.sh](#fileGeneratorsh): generate file with specific file name and file size
    - :floppy_disk: [letterCounter.sh](#letterCountersh): count letters and words in sentence
    - :a: [caseConverter.sh](#caseConvertersh): convert text to lower case, upper case, capitalized case, sentence case, alternating case and inverse case
    - :phone: [phoneNumVerifier.sh](#phoneNumVerifiersh): use [numverify](https://numverify.com) API to verify phone number
    - :signal_strength: [androidNetworkConfigure.sh](#androidNetworkConfiguresh): configure Android network security setting to trust custom CA on Android 7 and above. More details [here](https://developer.android.com/training/articles/security-config).
    - :euro: [showCurrencyCode.sh](#showCurrencyCodesh): show list of currency country, name and code. Use `grep` to filter out information.
    - :clipboard: [loremGenerator.sh](#loremGeneratorsh): generate lorem ipsum
    - :mag: [antideo.sh](#antideo.sh): call [Antideo](http://www.antideo.com) APIs to validate IP address, phone number or Email address

## jwtDecoder.sh

**[`^        back to top        ^`](#)**
```
~$ ./jwtDecoder.sh 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiJiMDhmODZhZi0zNWRhLTQ4ZjItOGZhYi1jZWYzOTA0NjYwYmQifQ.-xN_h82PHVTCMA9vdoHrcZxH-x5mb11y1537t3rGzcM'


{
  "typ": "JWT",
  "alg": "HS256"
}
{
  "userId": "b08f86af-35da-48f2-8fab-cef3904660bd"
}
```

## urlCoder.sh

**[`^        back to top        ^`](#)**

```
~$ ./urlCoder.sh 'https://www.w3schools.com/action_page2.php?text=Hello Günter'
https%3A%2F%2Fwww.w3schools.com%2Faction_page2.php%3Ftext%3DHello+G%C3%BCnter

~$ ./urlCoder.sh -d 'https%3A%2F%2Fwww.w3schools.com%2Faction_page2.php%3Ftext%3DHello+G%C3%BCnter'
https://www.w3schools.com/action_page2.php?text=Hello+Günter
```

## uuidValidator.sh

**[`^        back to top        ^`](#)**

```
~$ ./uuidValidator.sh 'x56a4180-h5aa-42ec-a945-5fd21dec0538'
x56a4180-h5aa-42ec-a945-5fd21dec0538
false

~$ ./uuidValidator.sh '{C56a418065aa426ca9455fd21deC0538}'
C56a4180-65aa-426c-a945-5fd21deC0538
true
```

## fileGenerator.sh

**[`^        back to top        ^`](#)**

```
1. Generate a 128k txt file, file name contains only numbers:
~$ ./fileGenerator.sh -o "0-9" -e ".txt" -s 128k

2. Generate a jpg file, flie name has 12 characters:
~$ ./fileGenerator.sh -l 12 -e ".jpg"

3. Generate a 5m mp4 file, flie name has 8 characters, contains capital letters:
~$ ./fileGenerator.sh -o "A-Z" -l 8 -e ".mp4" -s 5m
```

## letterCounter.sh

**[`^        back to top        ^`](#)**

```
~$ ./letterCounter.sh 'So God created man in his own image, in the image of God created he him; male and female created he them.'
Character: 105
Word: 22
```
## caseConverter.sh

**[`^        back to top        ^`](#)**

```
~$ ./caseCoverter.sh -t 'across the dragoon and the fate' -A

Upper case:
ACROSS THE DRAGOON AND THE FATE

~$ ./caseCoverter.sh -t 'across the dragoon and the fate' -C

Capitalized case:
Across The Dragoon And The Fate

~$ ./caseCoverter.sh -t 'So God created man in his own image, in the image of God created he him; male and female created he them.' -aAcCsi

Upper case:
SO GOD CREATED MAN IN HIS OWN IMAGE, IN THE IMAGE OF GOD CREATED HE HIM; MALE AND FEMALE CREATED HE THEM.

Lower case:
so god created man in his own image, in the image of god created he him; male and female created he them.

Capitalized case:
So God Created Man In His Own Image, In The Image Of God Created He Him; Male And Female Created He Them.

Sentence case:
So God created man in his own image, in the image of God created he him; male and female created he them.

Alternating case:
So gOd CrEaTeD MaN iN hIs oWn ImAgE, iN tHe iMaGe oF GoD CrEaTeD hE hIm; mAlE AnD FeMaLe cReAtEd He ThEm.

Inverse case:
sO gOD CREATED MAN IN HIS OWN IMAGE, IN THE IMAGE OF gOD CREATED HE HIM; MALE AND FEMALE CREATED HE THEM.

```

## phoneNumVerifier.sh

**[`^        back to top        ^`](#)**

To use this script, it needs to register an API from numverify. And set global variable `NUMVERIFY_KEY`
```
export NUMVERIFY_KEY='<your-access-key>'
```

```
1. Query a phone number:
~$ ./phoneNumVerifier.sh 14158586273
{
  "valid": true,
  "number": "14158586273",
  "local_format": "4158586273",
  "international_format": "+14158586273",
  "country_prefix": "+1",
  "country_code": "US",
  "country_name": "United States of America",
  "location": "Novato",
  "carrier": "AT&T Mobility LLC",
  "line_type": "mobile"
}


2. List country codes:
~$ ./phoneNumVerifier.sh
{
  "AF": {
    "country_name": "Afghanistan",
    "dialling_code": "+93"
  },
  "AL": {
    "country_name": "Albania",
    "dialling_code": "+355"
  },
  "DZ": {
    "country_name": "Algeria",
    "dialling_code": "+213"
  },
  "AS": {
    "country_name": "American Samoa",
    "dialling_code": "+1"
  },
  ...
}
```

## androidNetworkConfigure.sh

**[`^        back to top        ^`](#)**

```
~$ ./androidNetworkConfigure.sh <path_to_AndroidManifest.xml>
```

## showCurrencyCode.sh

**[`^        back to top        ^`](#)**

```
~$ ./showCurrencyCode.sh | grep -i "<search_keyword>"
```

## loremGenerator.sh

**[`^        back to top        ^`](#)**

```
~$ ./loremGenerator.sh -p <paragraph_num> -l <max_line_length>
```

## antideo.sh

**[`^        back to top        ^`](#)**

:warning: Antideo provides only **10 requests/hour for free account**, need more requests? [Pay it](https://www.antideo.com/pricing), or tor it.

Validate IP address:

```
~$ ./antideo.sh -i 1.1.1.1
{
  "IP": "1.1.1.1",
  "health": {
    "toxic": false,
    "proxy": {
      "type": "open",
      "last_seen": "2019-04-21 00:40:04"
    },
    "spam": {
      "times_reported": 12,
      "last_seen": "2019-03-13 11:40:09"
    }
  }
}
```

Validate Phone number:

```
~$ ./antideo.sh -p +33143253700
{
  "phone": "+33143253700",
  "valid": true,
  "type": "FIXED_LINE",
  "location": "Paris",
  "timezones": [
    "Europe/Paris"
  ],
  "formats": {
    "E164": "+33143253700",
    "national": "01 43 25 37 00",
    "international": "+33 1 43 25 37 00"
  }
}
```

Validate Email address:

```
~$ ./antideo.sh -m ads@gmail.com
{
  "email": "ads@gmail.com",
  "free_provider": true,
  "spam": false,
  "scam": false,
  "disposable": false
}
```
