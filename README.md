#Tiny Documentation of project

[logo]: http://s17.postimg.org/riqhk05gv/97107058_410721552.jpg "Tiny Documentation"

##JSON API

We accept incoming JSON request on address __/claim__
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

###Examples of requests
####Successful request answer
    ...
    * upload completely sent off: 149 out of 149 bytes
    < HTTP/1.1 201 Created
    ...
    {"claim_id":53,"phone":"+1(51)555555"}
    ...

####Failure answer
    ...
    * upload completely sent off: 129 out of 129 bytes
    < HTTP/1.1 422 Unprocessable Entity
    ...
    {"text":[" не може бути порожнім"]}
    ...
