#include "levelloader.h"
#include <QFile>
#include <QTextStream>
#include <QDebug>

LevelLoader::LevelLoader(QObject *parent) : QObject(parent)
{
}

QString LevelLoader::loadMap()
{
    qDebug() << "loading level" << m_level;
    if (m_level == -1)
    {
        emit error ("level was not set!");
        return QString();
    }

    Q_INIT_RESOURCE(levels);
    QFile levelFile(":/levels/level_" + QString::number(m_level) + ".txt");
    QString fileContent;

    if (levelFile.open(QIODevice::ReadOnly)) {
        QString line;
        QTextStream t(&levelFile);
        do {
            line = t.readLine();
            fileContent += line + "\n";
        } while (!line.isNull());
        levelFile.close();
    }
    else {
        emit error("could not open level file!");
        return QString();
    }
    return fileContent;
}
