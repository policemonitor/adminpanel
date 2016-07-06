![](https://s31.postimg.org/ea4bt36u3/rsz_screenshot_from_2016_07_06_14_55_41.png)
> Providing support for police with automation of claim receiving process ([view presentation on Slide Share](http://www.slideshare.net/RomanKaporin/police-assistance-system-ukrainian-localization) or [download it](https://drive.google.com/file/d/0B8433SXZV3xVODFfMjRUM2NfaHc/view?usp=sharing)).

![Main window](https://s32.postimg.org/gs0svhwj9/rsz_screenshot_from_2016_07_06_14_24_11.png)
# Main server specifications
## How does it work
It's fantastic simple:
  1.  System receives claim with geolocation from somebody who is in trouble
  2.  Victim gets SMS with confirmation from police
  3.  System informs police officer about the crime
  4.  Police officer sends police crews to crime scene
  5.  Crews get details about victim
  6.  System gives notice to victim about arriving help

## Inside the system
System consists of two servers: _Main_ and _Support_. This document is about __Main__ server.
![](https://s32.postimg.org/3uzmheg1h/Snapseed.jpg)
Tasks of __Main__ server:
 - receiving claims
 - processing and storing
 - sending notifications to police crews and victims
 - supervising _support server_

## Tiny API for receiving claims [(the tiniest)](http://s17.postimg.org/riqhk05gv/97107058_410721552.jpg)
### JSON API for incoming claims
We accept incoming JSON request on address __/API__
It should be formated in the next way:

    '{
      "claim":
        {
          "lastname":"Jhon Smith",
          "phone":"+1(51)555555",
          "latitude":"10.4",
          "longitude":"12.7",
          "theme":"Test message",
          "text":"Text of test message"
        }
      }'


If your request was successful than you'll get answer with code 201
and your request id and its phone number.

In the other way you'll get code 421 (Unprocessable entity) and JSON array with
errors.

### Examples of requests
#### Successful request answer
    ...
    * upload completely sent off: 149 out of 149 bytes
    < HTTP/1.1 201 Created
    ...
    {"claim_id":53,"phone":"+1(51)555555"}
    ...

#### Failure answer
    ...
    * upload completely sent off: 129 out of 129 bytes
    < HTTP/1.1 422 Unprocessable Entity
    ...
    {"text":[" не може бути порожнім"]}
    ...
