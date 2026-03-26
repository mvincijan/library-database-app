from flask import Flask, render_template, request, redirect
import mysql.connector

app = Flask(__name__)

def get_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="2512LAPtop!",
        database="mydb"
    )

@app.route("/")
def index():
    return redirect("/posudba")

@app.route("/posudba", methods=["GET", "POST"])
def posudba():
    if request.method == "POST":
        conn = get_db()
        cursor = conn.cursor()

        sql = """
        INSERT INTO Posudba
        (datum_posudbe, datum_vracanja, rok_vracanja,
         Primjerak_idPrimjerak, Clan_idClan, Zaposlenik_idZaposlenik)
        VALUES (%s, NULL, %s, %s, %s, %s)
        """

        cursor.execute(sql, (
            request.form["datum_posudbe"],
            request.form["rok_vracanja"],
            request.form["primjerak"],
            request.form["clan"],
            request.form["zaposlenik"]
        ))

        conn.commit()
        conn.close()
        return redirect("/posudba")

    return render_template("posudba.html")

@app.route("/povrat_clan", methods=["GET", "POST"])
def povrat_clan():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)

    posudbe = []
    clan_id = None

    # Korak 1: Dohvati posudbe nakon što se unese ID clana
    if request.method == "POST" and "prikazi_posudbe" in request.form:
        clan_id = request.form.get("clan_id")
        cursor.execute("""
            SELECT p.idPosudba, k.naziv AS knjiga, p.datum_posudbe, p.rok_vracanja
            FROM Posudba p
            JOIN Primjerak pr ON p.Primjerak_idPrimjerak = pr.idPrimjerak
            JOIN Knjiga k ON pr.Knjiga_idKnjiga = k.idKnjiga
            WHERE p.Clan_idClan = %s AND p.datum_vracanja IS NULL
        """, (clan_id,))
        posudbe = cursor.fetchall()

    # Korak 2: Označavanje posudbe kao vraćene
    if request.method == "POST" and "vrati_posudbu" in request.form:
        idPosudba = request.form.get("idPosudba")
        datum_vracanja = request.form.get("datum_vracanja")
        cursor.execute("""
            UPDATE Posudba
            SET datum_vracanja = %s
            WHERE idPosudba = %s
        """, (datum_vracanja, idPosudba))
        conn.commit()
        # Ponovno dohvat posudbi da osvježi listu
        clan_id = request.form.get("clan_id")
        cursor.execute("""
            SELECT p.idPosudba, k.naziv AS knjiga, p.datum_posudbe, p.rok_vracanja
            FROM Posudba p
            JOIN Primjerak pr ON p.Primjerak_idPrimjerak = pr.idPrimjerak
            JOIN Knjiga k ON pr.Knjiga_idKnjiga = k.idKnjiga
            WHERE p.Clan_idClan = %s AND p.datum_vracanja IS NULL
        """, (clan_id,))
        posudbe = cursor.fetchall()

    conn.close()
    return render_template("povrat_clan.html", posudbe=posudbe, clan_id=clan_id)

@app.route("/obrisi_zakasninu/<int:idZakasnina>", methods=["POST"])
def obrisi_zakasninu(idZakasnina):
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM Zakasnina WHERE idZakasnina = %s", (idZakasnina,))
    conn.commit()
    conn.close()
    return redirect("/povrat")

@app.route("/produzi_rok/<int:idPosudba>", methods=["GET", "POST"])
def produzi_rok(idPosudba):
    conn = get_db()
    cursor = conn.cursor(dictionary=True)

    if request.method == "GET":
        cursor.execute("SELECT idPosudba, rok_vracanja FROM Posudba WHERE idPosudba = %s", (idPosudba,))
        posudba = cursor.fetchone()
        conn.close()
        return render_template("produzi_rok.html", posudba=posudba)

    if request.method == "POST":
        novi_rok = request.form["novi_rok"]
        cursor.execute("UPDATE Posudba SET rok_vracanja = %s WHERE idPosudba = %s", (novi_rok, idPosudba))
        conn.commit()
        conn.close()
        return redirect("/povrat_clan")



app.run(debug=True)
