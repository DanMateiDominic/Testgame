#ifndef LEVELLOADER_H
#define LEVELLOADER_H

#include <QObject>

class LevelLoader : public QObject
{
    Q_OBJECT

public:
    Q_PROPERTY(int level READ level WRITE setLevel NOTIFY levelChanged)

    explicit LevelLoader(QObject *parent = 0);

    Q_INVOKABLE QString loadMap();
    int level() {return m_level;}

public slots:
    void setLevel(const int& level) {m_level = level;}

signals:
    void levelChanged(const int& level);
    void error(const QString& error);

private:
    int m_level = -1;
};

#endif // LEVELLOADER_H
