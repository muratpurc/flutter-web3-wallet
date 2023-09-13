# web3_wallet

A crypto wallet project with Flutter based on the tutorial [Build a Crypto Wallet from Scratch with Flutter | Moralis Blueprints | Moralis API](https://www.youtube.com/watch?v=4qgZYgsE8TQ).

## Requirements

- [Flutter](https://docs.flutter.dev/get-started/install)
- [Set up an IDE](https://docs.flutter.dev/get-started/editor)
- [Python](https://www.python.org/downloads/)

## Develop or run web3_wallet

**Checkout from git repository**
````
git clone https://github.com/muratpurc/flutter-web3-wallet.git
````
**Create the .env file**

Copy the environment file `.env.example` to `.env`. 
- Set your Moralis API key. See [Moralis](https://moralis.io/) for more details. The registration is free and they have a free plan for developer which is completely sufficient for developing or testing this app. 
- Set your backend base url, see 'python backend (flusk app)' below.

**IDE for Flutter development**

Use [Visual Studio Code](https://docs.flutter.dev/tools/vs-code) or [Android Studio & IntelliJ](https://docs.flutter.dev/tools/android-studio) for development

**Python backend (flusk app)**

Start python backend (flusk app) from project root for api calls.

````
python ./backend/app.py
````

NOTE: You need to takeover the network url of the flusk app into your .env file e.g. `BACKEND_BASE_URL=http://192.168.1.100:5002`, see output of the running flusk app.

## Getting started with development of Flutter applications

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
