[codeclimate]: https://codeclimate.com/github/cippaciong/speechbot

# Speechbot

[![Code Climate](https://codeclimate.com/github/cippaciong/speechbot/badges/gpa.svg)][codeclimate]

Speech-to-text Bot for Telegram powerd by Google Cloud Speech.

If you'd like to try it, open: [telegram.me/speech2bot](https://telegram.me/speech2bot)

*At the time, audio files longer than 1 minute are not supported, sorry.*

## Disclaimer

The code quality is pre-alpha and you should expect any kind of error/bug/whatever.
The project itself is intended as an exercise for me to learn new things about programming, testing and software architecture.
If you think there is anything [smelly](https://en.wikipedia.org/wiki/Code_smell) in the code, please open an issue.

## Privacy

**Before using this software please read what follows.**

1. All audio files will be used by us with the sole intention of sending them to Google Cloud Speech for the recognition. We do not store your files permanently and we do not access them directly.
2. All audio files will be uploaded to the third party Google Cloud Plaftorm for the recognition. Make sure you agree with [Google privacy policy](https://support.google.com/work/answer/6056650) before using this bot.

*If you don't agree with this two conditions, simply refrain from using this bot.*

## Setup

If you want to use this code for yourself you will need a Telegram Bot API Token and a Google Speech Keyfile. We use [dotenv](https://github.com/bkeepers/dotenv) to manage them.

```
$ cat .env

# Telegram secrets
BOT_TOKEN=123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11

# Google Cloud Platform secrets
export SPEECH_KEYFILE=/path/to/key.json
export SPEECH_PROJECT="project-name"

```

Once you have them, install the required dependencies with `bundle install --path .bundle`

## Usage

Start the bot running `bundle exec rackup`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cippaciong/speechbot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

Yet to decide.

