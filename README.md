# test_xslt
Задание по написанию XSLT преобразования для XML файла.

## Список файлов
- 1_original_order.xml – Файл XML с данными из группы 1
- 3_converted_order.xml — Файл XML с данными из группы 1 после преобразования
- 2_converted_order.xsl — Файл XSL для преобразования в группе 1
- original_4.xml — Файл XML с данными из группы 2 для преобразования
- **transform.xsl — Файл XSL для преобразования в группе 2**
- output.xml — Файл XML с данными из группы 2 после преобразования
- launch.json – Запуск скрипта для преобразования в соответствии с правиламми в XSL файле
- settings.json – Указывается ссылка на файл запуска процессора Saxon

## ПО
Для работы с кодом использовался Visual Studio Code Version: 1.96.4 (Universal) с расширением XSL Transform.
Для запуска расширения установлены:
- Java — [ссылка на скачивание](https://download.oracle.com/java/23/latest/jdk-23_macos-aarch64_bin.dmg)
- Saxon XSLT processor [ссылка на скачивание](https://github.com/Saxonica/Saxon-HE/releases/download/SaxonHE12-5/SaxonHE12-5J.zip)

## Подключение и работа
После установки ПО необходимо в VS Code в разделе /Settings/Extensions найти XSL Transform прописать путь к процессору Saxon (.jar) и к файлу преобразования (.xsl)

<img width="499" alt="image" src="https://github.com/user-attachments/assets/81aa03ce-c6c0-4926-8b6b-629484e4741f" />

Далее необходимо создать файл launch.jason, после чего запустить Debugging.
