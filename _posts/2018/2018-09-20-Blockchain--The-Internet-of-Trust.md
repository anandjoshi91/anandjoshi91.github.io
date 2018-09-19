---
layout: post
title: Blockchain -  The Internet Of Trust 
excerpt: "Going beyond bitcoin to understand various other applications of blockchain"
categories: [geek]
tag: [geek,bitcoin,blockchain,cryptocurrency]
comments: true
author: Anand
image:
  feature: /2018/blockchain.png
---

"Well, I told you, it was a bubble..." You must have heard many people say this after the epic fall of the bitcoin and other cryptocurrencies in the past year. Yeah, sure it was a bubble but we are not going to talk about that, instead, we would be focusing on the core technology - Blockchain and its applications in many other domains other than cryptocurrencies. 


> It is funny to see how people overestimate what a technology can do in a couple of years and underestimate what it can in a decade.


In the [last article](/articles/2017-12/Understanding-Bitcoin){:target="_blank"} we learned about the inner workings of the `bitcoin`. We learned that blockchain is essentially a distributed, an open-ended [free for users to join or leave the network at will], non-mutable [can not be changed once agreeded] ledger. 

The bitcoin blockchain ledger contains transaction entries, but what stops anyone from creating another blockchain where instead of the coins and transaction entries in the ledger, some other data is stored. It could be used to build a robust distributed database in which anyone could write and read and the integrity of the data is protected in a similar way as the bitcoin's protocol works. This opens up a whole new world of opportunities.


> "A database that is shared by multiple writers who don’t entirely trust each other, who modify that database directly and where there is some interaction between the transactions created by these writers." - Gideon Greenspan [Founder of multichain]


If you understand the above definition of a blockchain clearly then you have certainly understood where a blockchain would be useful and where it would be [pointless](https://www.multichain.com/blog/2015/11/avoiding-pointless-blockchain-project/){:target="_blank"} to use a blockchain instead of the existing solutions.


<p align="center">
    <img src="/img/2018/do-you-need-blockchain.png" alt="do-you-need-blockchain" />
</p>


So next time your manager barges in and talks about doing this new project using blockchain, please sit with him and ask him what exactly is he trying to solve? How exactly a blockchain will be useful when a traditional database which is much faster and scalable can do the same thing.


<p align="center">
    <img src="/img/2018/blockchain-joke.jpg" alt="blockchain-joke" />
</p>


### Alternate blockchains and their use cases - 
- [**Ethereum -**](https://www.ethereum.org/){:target="_blank"} Technology to build decentralised applications. Bitcoin also provides a simple stack-based [scripting language](https://en.bitcoin.it/wiki/Script){:target="_blank"} to write some simple contracts like an escrow using [MultiSig](https://en.bitcoin.it/wiki/Multisignature){:target="_blank"}. On the other hand, the ethereum blockchain provides a more robust and Turing complete language - Solidity to the developers working on ethereum blockchain which can be used to build more complex decentralized apps, smart contracts, tokens and more.
- [**IPFS -**](https://ipfs.io/){:target="_blank"} What if instead of hosting your website/files on a server you could just host it on a peer to peer network powered by another blockchain. No government or authority would be able to bring down such a website!
- [**Golem -**](https://golem.network/){:target="_blank"} Share computation power. Build the world's biggest supercomputer.


### Other applications of a blockchain

<p align="center">
    <img src="/img/2018/Blockchain-Applications.jpeg" alt="Blockchain-Applications" />
</p>


### Problems with blockchain
- The `Proof of work` consensus mechanism uses an immense amount of energy.
- Increasing cost of mining fees.
- Slow when compared to traditional methods.

<p align="center">
    <img src="/img/2018/blockchain-slow-meme.png" alt="blockchain-slow-meme" />
</p>

### Other novel ideas
- There are various experimentation going on reduce the energy wastage caused by the Proof of Work consensus algorithm. Alternate consensus algorithms like Proof of stake, Proof of Elapsed time etc are being tested out to see their viability of existing mechanisms.
- An improvement over the blockchain latency is being tacked by new ideas which use completely different data structures other than "chain of blocks". One such example is [HashGraph](https://www.hederahashgraph.com/).
- Not all blockchains are public and open to all, some of them could be regulated and would require permission to join. Such blockchains could be used by Government, Private companies or group of companies requiring some shared data which should not be public, yet the members would like the power to be distributed amongst the participating members. Such private and hybrid blockchains are also coming up.

## Next
I think by now you have enough background and motivation to understand what a blockchain is, what does it try to solve and what are its drawbacks and where can it truly add a value. Now enough of talking! In the next article, we will get our hands dirty on some real-world problem and create our very first blockchain application.