import speech_recognition as sr

def recognize_speech_from_microphone():
    recognizer = sr.Recognizer()

    with sr.Microphone() as source:
        print("Говорите что-то...")
        recognizer.adjust_for_ambient_noise(source)  # Убрать фоновой шум
        audio = recognizer.listen(source, timeout=10)

    try:
        print("Вы сказали: " + recognizer.recognize_google(audio, language="ru-RU"))
    except sr.UnknownValueError:
        print("Речь не распознана")
    except sr.RequestError as e:
        print("Произошла ошибка в запросе к сервису распознавания: {0}".format(e))

if __name__ == "__main__":
    recognize_speech_from_microphone()