---
layout: post
title: Understanding Bitcoin
excerpt: "Exploring the inner workings of bitcoin"
categories: [geek]
tag: [geek,bitcoin,blockchain,cryptocurrency]
comments: true
author: Anand
image:
  feature: /2017/bitcoin.PNG
---


Welcome to part 2 of the article series exploring our monetary system, bitcoin, and blockchain. In the [last article](/articles/2017-11/Decrypting-Crypto-Currencies){:target="_blank"} we learned about our monetary system and the problems associated with it. In this article, we will try to understand inner workings of `bitcoin`.

## Decentralised system
When Tim Berners Lee invented the `World Wide Web`, he envisioned an open and connected world where anyone can simply start a server and share their content with the world. Nobody owns internet yet everybody is a part of it. The internet is one of the finest examples of a decentralized system. Though over years, there has been a massive concentration of the power and this is because these big giants like Amazon, Google, FaceBook etc provide ease and convenience through their services, luring people to route the world wide web through their systems. And we also see the problems with it - NSA spying on us by partnering with these big companies. Governments censoring internet etc. Going ahead we'll see how a blockchain can help in redesigning the World Wide Web so that it truly becomes decentralized as it was intended to be.

A truly decentralized system is such a system that does not have any central authority. The system works by the interaction of the peers amongst themselves. People are free to join the system, they are also free to leave it if they wish so. It is very difficult to bring down such a system, because you don't know who are the entities of this system. For example look at BitTorrent - it is a simple peer to peer file sharing protocol. No matter how hard governments try they will never be able to uproot it completely and on the other hand see how easy it was for the government to bring down a centralized - peer to peer file sharing system - Napster.

<p align="center">
    <img src="/img/2017/centralised-decentralised-distributed.png" alt="centralised-decentralised-distributed" />
</p>

So now we can appreciate the tenacity of a decentralized system. But there are also some problems akin to such systems. Since there is no one really in charge of such a system, you could see some entities harming others, building their associates having common malicious intentions. And it is very difficult to keep a decentralized system healthy and free of malicious agents unless we don't employ central authorities that guard the system against such agents. So we see, here we have a trade-off between the freedom of decentralized system and security of a centralized system. No matter that Google/Facebook/Microsoft do have control over our personal data, but they also try to prevent it from hackers and other malicious agents.

So now that you're somewhat familiar with a decentralized system, let us try to understand what is Bitcoin.

## Bitcoin
Bitcoin is a digital cash/coin that is tracked by transaction entries in a ledger. Cool, that was simple. Umm.. so who is responsible for maintaining this ledger? -"Nobody". In fact, no single person or a central authority maintains or controls it, but rather the users and the community as a whole maintain it. But now you may ask, how do you ensure that all the ledger entries are the same? What if some malicious users in the network enter wrong entries into the ledger or worst send same money to two users, i.e double spend. How can all the nodes in the network come to a consensus about an entry in a ledger. These are some tough challenges for a decentralized application and let us try to understand each one of them separately and see how Satoshi-San cleverly bootstrapped a decentralized coin which seemed impossible to solve at first glance. 

<p align="center">
    <img src="/img/2017/centralized-and-distributed-ledger.jpg" alt="centralized-and-distributed-ledger" />
</p>

### How does it work?

We'll break down this into small blocks and link them one by one [pun intended] to build our understanding of this system.

1. [Hashes](https://learncryptography.com/hash-functions/what-are-hash-functions){:target="_blank"} -  In math and computer science a hash is a one way function that takes any string, number, text or any digital piece of information, runs an algorithm and converts it into a unique and short representation of that digital information, called a hash. Another property of hash is such that if the input was to be changed even slightly then the resulting hash would be very different. Hence you could use the hash to ensure that the digital data that you have was not tampered with and if it was then the resulting hash would be different and you could identify it quickly. Also note that given a hash, it is impossible to find out what the original input was.

<p align="center">
    <img src="/img/2017/hashing.PNG" alt="hashing" />
</p>

2. [Assytemtric cryptography](https://en.wikipedia.org/wiki/Public-key_cryptography){:target="_blank"} - In an asymmetric cryptography, a user generates two keys - private key and public key. As the name suggests the private key is personal and not revealed to anyone whereas the public key can be freely shared with everyone. If a person wants to send any message/data he will sign it with his private key [think of this sign as a hash produced by taking the private key and the data/message as the input]. Asymmetric cryptography is such that, now anyone can verify that this data/message was really signed by that same person. If an intruder tries to change the signed copy of the data then the verification will fail and anyone reading this data/message will come to know this message has been tampered with.

3. Immutable ledgers - As described above bitcoin is nothing but a distributed ledger shared and updated by its users. The ledger is such that any entry written into it cannot be forged or edited. And of course by now you are smart enough to realize this verification would be possible by checking the hash. So what do these ledgers contain? It simply contains a message like "Mr. A sends x amount of coins to Ms. B" and it is digitally signed as explained above by Mr. A's private key. Now anyone can verify this by checking it with Mr. A's public key. Now rather than using Mr. A's real name in the transaction, the transaction contains A's public address which is his public key. Hence Bitcoin provides pseudo-anonymity. As far as you keep using random addresses for each transaction, no one will be able to identify you. Okay, now the list of such messages having transactions of the coins are called blocks. Each block is connected to a previous block of transactions through hashes such that if any one of the blocks is fudged then all the blocks before and including it gets a different resulting hash and this creates what is called a "fork" in the chain. Now bitcoin is designed such that whenever a fork happens all the nodes chose the chain having the largest number of blocks. Now you may ask, what if the malicious users start building a longer chain together? Yes, they can but bitcoin prevents this through `Proof of Work` which we'll explore once we understand the consensus algorithm.


<p align="center">
    <img src="/img/2017/asymmetric-cryptography.png" alt="asymmetric-cryptography" />
</p>




4. Consensus - Now we come to the most important part of the bitcoin system. Consensus means an agreement of all the nodes that the ledger has same values. This is the heart of the bitcoin design as you see it has many challenges. Let us first list down the bitcoin consensus algorithm and then dive deeper into it.

<p align="center">
    <img src="/img/2017/blockchain-mining-consensus.jpg" alt="blockchain-mining-consensus" />
</p>



The algorithm.
- When any person exchanges bitcoin with another person they are broadcasted to all the nodes in the bitcoin network.
- Each node collects these new transactions into a block [currently block of size 1 MB].
- In each round, a random(we'll get to this later) node gets to broadcast its block.
- Other nodes accept the block if all the transactions are valid [coin spending, valid signatures etc]
- Nodes express their acceptance of the block by including its hash in the next block that they create.

Okay. So this was fairly simple. Now let us check what a malicious node can do in such a system and how bitcoin prevents it?

a. Steal other person's coin
- If someone tries to do that then they can not "sign" the block or use the coins as they do not have the "private key" as far as the private key is safe, there is no way to spend someone's coin even if they are stolen! There are further methods like [secret sharing algorithm](https://en.wikipedia.org/wiki/Shamir%27s_Secret_Sharing){:target="_blank"} to make your keys more secure.

b. Deny transaction to a person
- Nodes are chosen randomly(more on it later). Hence in later rounds, an honest node will get that transaction and process it. So this too isn't an issue.

c. Double spend the coins
- As described before in case of two or more versions of chains a _fork_ happens and bitcoin is programmed to automatically picks up the longest chain. As long as the honest members keep building the blocks it will be difficult for the malicious attackers to outpace and build a longer chain. The longer the chain gets the more trust it builds [we'll see this how in a minute] and hence after receiving coins we wait for some more blocks to be added on top of our block to get a longer chain and more confidence that this transaction forms part of the universally agreed ledger or consensus chain. [Currently, we wait for 6 confirmations I,e wait for 6 more blocks to be added to the block before we sign the deal. 6 is just an accepted number, you could wait more or less number of transactions depending on the stake of the deal you're doing it !]


<p align="center">
    <figure>
        <img src="/img/2017/forking.png" alt="blockchain-forking" />
        <figcaption>Forking in bitcoin blockchain</figcaption>
    </figure>
</p>


###  Proof of work
So after understanding the basic mechanism of a blockchain the obvious questions in your mind would be, how does bitcoin ensure that the nodes remain honest? Bitcoin solves this problem by incentivizing the nodes that provide a correct and valid block. The node is rewarded by 12.5 BTC [currently] and is halved every 4 years. [Eventually becoming close to zero, but never really zero, and roughly having 21 million bitcoins by 2140] The second incentive is transaction fees. The node processing the transaction can levy certain transaction fee. This mechanism of incentives encourages nodes to remain honest and cooperate rather than cheat and destroy the system. 

The second question would be how can it ensure, some malicious nodes don't just add number of blocks and build a longer chain to displace the honest and valid chain. Bitcoin solves this by making the process of block creation expensive for a node. Each node is given a mathematical puzzle - a hash puzzle that can only be solved by trying a very large number of random guesses. So at a given time, all the nodes in the bitcoin network are solving this puzzle and the node that gets the right answer wins and gets to include its block in the chain. This process is called `mining` as the node is rewarded with fresh new coins for solving this puzzle. Okay so you get what mining is but still, you would be thinking, what is the real purpose of doing this? Yes, it indeed has a deeper implication for the security of the network. Mining is computationally expensive and non-deterministic hence the first problem it resolves is that no node can gain the monopoly in creating the next block and thus monopoly in earning the block reward. Second it prevents the [Sybil attack](https://en.wikipedia.org/wiki/Sybil_attack){:target="_blank"}, that is a single adversary controlling multiple nodes. Adding more nodes entails buying expensive computers and processors and hence makes it unviable for the adversary. Now you can understand why it is expensive for an adversary to fork and build another longest chain. As long as 50% of the users are honest [they are lured to be through clever incentive mechanisms] you can be certain that blockchain is safe. Note that an adversary planning to do a [51% attack](https://www.investopedia.com/terms/1/51-attack.asp){:target="_blank"} needs to amass computing power more than first 500 supercomputers in the world as of now. Going ahead as more and more nodes start linking to bitcoin network this will become even harder and virtually unhackable.

Another question you might have is, as more and more nodes start mining, it should be easy and faster for the network to mine the coins. The current design of bitcoin system is such that the difficulty of the puzzle is parameterized. That means, currently it is programmed to re-calculate the difficulty of the puzzle in the entire bitcoin network every 2 weeks. So if more nodes join the network, then the difficulty also increases and vice-versa. This re-tuning of the difficulty ensures that the average block generation time is roughly 10 minutes.


## Summary

Now let us summarise by watching this video which shows a live blockchain example.

<center>
    <iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/_160oMzblY8" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>
</center>


## Conclusion
I hope that you can understand how bitcoin works and appreciate how it presents to the world a financial instrument of the [free market](https://www.investopedia.com/terms/f/freemarket.asp){:target="_blank"}.Again if you feel like reading more then you should read the [white paper](https://bitcoin.org/bitcoin.pdf){:target="_blank"} authored by Satoshi Nakamoto.


## Next
 In the next article, we will understand what are the issues currently faced by bitcoin blockchain. We'll try and get a broader and wider application of the underlying technology used in bitcoin - `the blockchain` and explore some interesting and disruptive applications of it outside the world of finance. We will also see what the future of cryptocurrencies would be like.


I hope this was helpful. I would be happy to take your questions/suggestions and feedback.
{: .notice}