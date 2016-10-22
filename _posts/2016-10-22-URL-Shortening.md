---
layout: post
title: URL Shortening
excerpt: "Short and sweet :)"
categories: [geek]
tag: [url shortening,url shorteners,geek]
comments: true
author: Anand
image:
  feature: turn-long-short.jpg
---

## URL Shorteners :
Well, so you are tweeting about this amazing video which you think would be a big hit on the social media.
You open your twitter account, copy the URL and paste it to tweet, but wait ! The URL itself is 140+ characters, let alone your quirky comments.

And then you hear about these amazing tools called - URL Shorteners. They convert the dirty looking urls into short, sweet and slick urls, which can not only be easily shared on twitter and other media but they also provide you a hell lot of analytics and user information.

**Here are some commonly used URL shorteners :**
1. [bit.ly](https://bitly.com/){:target="_blank"} 
2. [goo.gl](https://goo.gl/){:target="_blank"} 
3. [ow.ly](http://ow.ly/url/shorten-url){:target="_blank"} 


## Well, but how does URL shortening work ?

![url-shortening](/img/url-short.jpg)

Let us paraphrase what URL shortening tools do. They convert a long arbitrary length of string into a short and compact combination of characters, which has much smaller length than the original URL. So if we understand this, we
also understand that essentially these tools are just mapping one set to another, but where one set is very large, probably infinite where as the other is a smaller and finite set. Does this sound a bit familiar to the computer science guys ? Yes this is ``` Hashing ``` ! It has wide usage from designing a HashMap, Lookup tables to creating a md5 hash for cryptographic purpose.

![hashing](/img/hashing.PNG)

## A demo project

Let us create a small ``` django project ``` to uderstand how URL shortening work.
You may fork my project [url-shortener](https://github.com/anandjoshi91/url-shortener){:target="_blank"}  from the GitHub.

After forking the above repo, change the log path in ``` shorturl/settings.py ``` and run the application by typing the following command
~~~
python manage.py runserver
~~~

This will create the ``` shorturl/db.sqlite3 ``` file. After this run the DB migrations to create the required tables by using the following command.
~~~
python manage.py migrate
~~~

### This is how the home page looks.

![url-shortener-home](/img/url-shortener-home.PNG)

### Compact URL after shortening it.
![url-shorten](/img/url-shorten.PNG)

The heart of the project is to understand how to write a good [Hashing function.](http://www.eternallyconfuzzled.com/tuts/algorithms/jsw_tut_hashing.aspx){:target="_blank"}

Let us look at the the **_model.py_** inside the smallify app in the above project.

~~~python
class URL(models.Model):
    original_url = models.CharField(max_length=300, unique= True)
    shortened_url = models.CharField(max_length=30, unique =  True)
    
    def shorten_url(self):
        self.shortened_url = self.__fnv_hash(self.original_url)
        
        if(len(self.shortened_url) >= len(self.original_url)):
            self.shortened_url =  self.original_url
        
        
    @staticmethod
    def __fnv_hash(key):
        h = 2166136261
        
        for k in key:
            h = (h*16777619)^ord(k)
        
        # Return 8 bit URL
        return base64.encode(h%281474976710656)
    
    def __str__(self):
        return models.Model.__str__(self)  
~~~

It makes use of the [FNV hashing algorithm](http://www.isthe.com/chongo/tech/comp/fnv/){:target="_blank"}.
Look at the private method ``` __fnv_hash ``` in the above code snippet. It converts an arbitary length of string _key_ into a 8 bit URL. Here every character of the key (original url) is XORed with a random integer **h** which is also multiplied at each stage to get a good folding effect. XORing gives a good uniform distribution. After this we encode the  given integer to [base64](https://en.wikipedia.org/wiki/Base64){:target="_blank"}. Like a binary base has only 2 digits to represent every possible number, base64 uses 64 different characters. This gives us a more compact representation of the integer **h**. Finally, we do modular division by _(281474976710655 + 1)_ to get a 8 bit compact URL.

### Why 281474976710656 ?

As we can see from the below commands, the 64th character (starts with 0 to 63) is an underscore ``` " _ " ```. So the value of 8 consecutive ``` " _ " ``` is 281474976710655 and hence we do a modular division with (281474976710655 + 1)

![encoding-url-shortener](/img/encoding-url-shortener.PNG)

With this, we have some basic understanding of URL Shorteners. The demo project [url-shortener](https://github.com/anandjoshi91/url-shortener){:target="_blank"} in quite naive and created for this tutorial. Do check it out and let me know if you have any improvements in it. Feel free to send a pull request and looking forward to your views, opinions, and tips in the comments below.
{: .notice}