---
layout: post
title: Security Basics
excerpt: "A crash course on security"
categories: [geek]
tag: [geek,security,cryptography,digital certificates,message authentication code,web security]
comments: true
author: Anand
image:
  feature: /2019/web-security.png
---
It's been more than a year since I have written any new post, and I do have really good excuses, if I may say, to corroborate my claim, but that's for another post! In this post, we will get a bit nerdy and revise some of the basics of security. You may use this as a quick guide or a crash course to recall these topics.

## Topics

1. [Web Security](#web-security)
2. [Encryption](#encryption)  
3. [Message Authentication Codes](#message-authentication-codes)
4. [Digital Signatures](#digital-signatures)
5. [Digital Certificates](#digital-certificates)

## Web Security

When exchanging data over the web, the data passes through a number of networks and devices. Some of these channels might not be safe and might have malicious entities, hence security technology are essential for the safety of their users. Let's look at the 4 prominent problems that can occur when data is transferred across the internet.

**1)** When Alice sends a message to Bob it can be intercepted by Eve
during the transmission. This is called `interception`.

<div class="mermaid">
sequenceDiagram
    participant Alice
    participant Eve
    participant Bob
 
    Alice->>Eve: "My bank details are xxx"
    Note right of Alice: Sharing important <br> details without <br> encryption
    Note over Eve: Eavesdropper <br> intercepting message
    Eve->>Bob: "My bank details are xxx" 
</div>

**2)** Even though Alice meant for the message to be sent to Bob, there is a chance that Eve was posing as Bob. Conversely, although Bob believes he received a message from Alice there's a chance it was Eve posing as Alice. This is called `spoofing`.

<div class="mermaid">
sequenceDiagram
    participant Bob
    participant Eve

    Bob->>Eve: Hello
    Eve->>Bob: Hello Bob, Alice here
    Note over Bob, Eve: Poor Bob thinks he is talking to Alice
</div>

**3)** Even if the message was transmitted by Alice to Bob, Eve could have overwritten the message during transmission. This is called `falsification`. In addition to intentional falsification by third parties, there's also the chance the delivered message was corrupted by malfunctioning devices or channels.

<div class="mermaid">
sequenceDiagram
    participant Alice
    participant Eve
    participant Bob
 
    Alice->>Eve: I love you <3
    Note over Eve: Message modified by <br> malicious entity
    Eve->>Bob: I hate you !
    Bob->>Alice: I am breaking up with you !!
</div>

**4)** While Bob believes he received a message from Alice if the sender of the message Alice had some malicious intent there is a chance she might insist later that she did not send that message ! This problem is called `repudiation`.

<div class="mermaid">
sequenceDiagram
    participant Alice
    participant Bob

    Alice->>Bob: I would like to order it...
    Note over Bob, Alice: Bob ships the items
    Bob->>Alice: Thanks. That will be $500
    Alice->>Bob: Sorry. I had not ordered anything 
</div>

These four problems are not limited to exchanges between people, but can also occur while browsing a website.

Here are the ways in which we can address the above mentioned problems.

| No. | Problem       | Solution                                          |
|-----|---------------|---------------------------------------------------|
| 1   | Interception  | Encryption                                        |
| 2   | Spoofing      | Message Authentication Code or Digital Signatures |
| 3   | Falsification | Message Authentication Code or Digital Signatures |
| 4   | Repudiation   | Digital Signatures                                |

Furthermore, `digital certificate` also helps to solve the inherent problem of not being able to verify the public key's owner in digital signatures.

## Encryption

Encryption is the process of encoding a message or information in such a way that only authorized parties can access it and those who are not authorized cannot. In an encryption scheme, the intended information or message, referred to as `plaintext`, is encrypted using an encryption algorithm – a `cipher` – generating `ciphertext` that can be read only if decrypted.

These are the types of encryption systems.

1. **Shared-Key Cryptosystem** : The sender and receiver use identical keys to encode and decode the message. Since the same key is used this type of system processes data much faster but the issue is how do we safely transfer this key. One way to do this is by using [Diffie–Hellman key exchange](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange){:target="_blank"} algorithm. Some examples - Caesar Cipher, AES, DES, OTP.

2. **Public-Key Cryptosystem** : It uses two different keys. The `public key` is used for encryption and the `private key` is used for decryption. It is easy to safely share the public key in this system however the data processing is a bit slow compared to the Shared-Key Cryptosystem. Some examples - [RSA Encryption](https://onlinequicktool.com/rsa-key-generator/){:target="_blank"}, Elliptic Curve Cryptography.

3. **Hybrid-Key Cryptosystem** : This system combines the above two systems to compensate for eachother's drawbacks. Here we safely exchange a key over an insecure channel by using Public-Key Cryptosystem. After this all subsequent communication happens by using this exchanged key, just like in a Shared-Key Cryptosystem.

You can read the application of the above cryptography systems in my articles on [Blockchain](/articles/2017-12/Understanding-Bitcoin){:target="_blank"}.

## Message Authentication Codes

Message Authentication Codes (MAC) are used to verify that the message received from the sender is not modified and is in-fact the original intended message.

In this mechanism both the sender and the receiver, use a shared secret key. This key is not known to anyone else [Similar to Shared-Key Cryptosystem]. While sending the message the sender calculates the hash of the message using the secret key, this generated code or checksum value is called `MAC`. The sender sends this MAC along with the original message. The receiver on receiving the message calculates the MAC again from the message and compares it with the MAC sent by the sender. If the MACs are different than the message is discarded and not trusted. Since the key is secret, the interceptor can not modify and correctly generate the MAC.

<div class="mermaid">
sequenceDiagram
    participant Alice
    participant Eve
    participant Bob

    Note over Alice: Message (m1)=<br>"Contract conditions <br> are xyz..."
    Note over Alice: MAC (mac1) = <br>h(m1,secret-key)   
    Alice->>Eve: m1+mac1
    Note over Eve: Eve modifies the <br> message, but could<br>not generate mac
    Note over Eve: m2 = Contract <br> conditions are abc...
    Eve->>Bob: m2+mac1
    Note over Bob: Mac (mac2) = <br>h(m2, secret-key)
    Note over Bob, Alice: mac1 != mac2. Maybe someone has changed the contract details !
    Bob->>Alice: Send the details again !
</div>

The above discussed method is called Hashed based message authentication code or `HMAC`. An alternative to HMAC could be `CMAC` which is Cipher based message authentication code.

## Digital Signatures

A digital signature system guarantees non-repudiation in addition to authentication and falsification
detection, the two functions implemented by message authentication codes. It uses public key cryptography to generate a signature. The process is quite similar to HMAC as described above. The MAC generated is encrypted by the private key of the sender. The receiver will calculate the MAC from the received message and compare it by decrypting the MAC. The decryption is done using the sender's public key. The encrypted MAC can be used as a `Digital Signature` of the sender. However, there is one problem with this. How do we ensure that the public key of the sender is indeed the one claimed by the sender ? This is solved by `Digital Certificate`.

<img src="/img/2019/digital-sig.png" alt="Digital Signature" />


## Digital Certificates

Using a `Digital Certificate` we can guarantee who the creator of the public key is.

A digital certificate contains public key, registered user details, email address, website or domain information. This certificate is issued by a recognized third party usually called CA or `Certification Authority`. 

The certificate authority has their own public keys and secret keys that they generate themselves. If Alice wants her digital certificate, she prepares her personal information including her public key and sends it to a CA. The CA after confirmation of the details use their secret key to sign or create a digital signature from Alice's data. The digital signature and the user data is combined into a file and sent to Alice. This becomes Alice's digital certificate.

<div class="mermaid">
sequenceDiagram
    participant Alice
    participant Certificate Authority

    Note over Alice: Prepare details <br> public key, email, <br> domain details ... 
    Alice->>Certificate Authority: Send personal details
    Note over Certificate Authority: Verify the details
    Note over Certificate Authority: Sign the details
    Certificate Authority->>Alice: Send back Digital Certificate
</div>

Now if anyone wants to interact with Alice they would first request her Digital Certificate. Then they would acquire CA's public key to verify the signature. This way we can be sure about the identity of Alice. Once the identity is confirmed the user can use Alice's public key to securely communicate with Alice using [Hybrid Cryptosystem](#encryption) as described earlier. This is how the SSL certificates work. Instead of a person Alice, it is the website and your browser does the work of verifying the certificate with CAs.

<div class="mermaid">
sequenceDiagram
    participant somewebsite.com
    participant Bob
    participant Certificate Authority

   Bob->>somewebsite.com: 1. Requests for SSL Certificate
   somewebsite.com->>Bob: 2. Sends SSL Certificate
   Bob->>Certificate Authority: 3. Requests CAs public key
   Certificate Authority->>Bob: 4. Sends public key
   Note over Bob: 5. Verifies signature
   Note over Bob: 6. On successful <br> verification uses <br> public key of website <br> to share secret key
   Bob->>somewebsite.com: 7. Sends secret shared key
   Note over somewebsite.com, Bob: 8. Use this shared key for secure <br> communication 
</div>

Hope this gives you some more idea about how cryptography is used for web security. Let me know your thoughts and suggestions in the comment section below.
{: .notice}