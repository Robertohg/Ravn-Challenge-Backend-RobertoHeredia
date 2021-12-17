import json
import sqlite3

def get_my_jsonified_data(key, x = 10):
    with sqlite3.connect('test.db') as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT TOP "+str(x)+" si.customer_name, sum(si.item_price * si.quantity) AS venta FROM sale_items si INNER JOIN books b ON si.book_id =b.id INNER JOIN authors a ON b.author_id =a.idGROUP BY si.customer_name ORDER BY 2 DESC;", [key])
        data = cursor.fetchall()
        return json.dumps(data)
    
