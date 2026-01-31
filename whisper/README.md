# Whisper Voice Dictation with Custom Vocabulary

Voice-to-text dictation using Whisper.cpp base model with custom vocabulary support for technical terms.

## Features

- Fast transcription using Whisper base model
- Custom vocabulary correction for technical terms
- Support for terms like CUDA, CLAUDE.md, Docker, etc.
- Easy to add new custom terms

## Installation

```bash
./install.sh
```

This will:
- Install system dependencies
- Clone and build whisper.cpp
- Download the base.en model
- Set up vocabulary correction scripts

## Usage

1. Bind `~/dictate.sh` to a keyboard shortcut in your system settings
2. Press the shortcut to start recording
3. Speak your text
4. Press the shortcut again to stop and transcribe
5. The transcribed text will be typed automatically with corrected vocabulary

## Adding Custom Vocabulary

Edit `tech_vocab.txt` to add your own terms:

```
# Format: wrong_transcription -> correct_term
cuda -> CUDA
coda -> CUDA
couda -> CUDA

claude -> Claude
clawed -> Claude

myapp -> MyApp
my app -> MyApp
```

The script will automatically correct common misrecognitions from Whisper.

## How It Works

1. Whisper base model transcribes audio quickly but may get technical terms wrong
2. Post-processing script applies vocabulary corrections
3. Corrected text is typed into your application

## Files

- `dictate.sh` - Main dictation script
- `vocab_correct.sh` - Post-processing vocabulary correction
- `tech_vocab.txt` - Custom vocabulary mappings
- `install.sh` - Installation script

## Tips

- Add common misrecognitions of your specific terms to `tech_vocab.txt`
- Test by saying technical terms and see how Whisper transcribes them
- Add multiple variations (cuda, coda, kuda) all mapping to CUDA
