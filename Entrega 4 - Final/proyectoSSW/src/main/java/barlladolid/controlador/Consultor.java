package barlladolid.controlador;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Consultor {
    private Connection conn;
    
    public Consultor(HttpServletRequest request){
        try{
            Class.forName("org.mariadb.jdbc.Driver");
            String url = "jdbc:mariadb://localhost:3306/mysql";
            String user = "root";
            String passwd = "root";
            this.conn = DriverManager.getConnection(url, user, passwd);

        }catch (Exception ex) {        
                System.out.println(ex.getMessage());
        } 
    }
    
    public ResultSet realizarConsulta(String consulta, ArrayList<String> values) throws SQLException{
        PreparedStatement stmt = this.conn.prepareStatement(consulta);
        if(values != null){
            for (int i = 0; i<values.size(); i++){
                stmt.setString(i+1, values.get(i));
            }
        }    
        ResultSet rs = stmt.executeQuery();
           
        return rs;

    }
    
    public void insertarValor(String consulta, ArrayList<String> values) throws SQLException{
        PreparedStatement stmt = this.conn.prepareStatement(consulta);
        if(values != null){
            for (int i = 0; i<values.size(); i++){
                stmt.setString(i+1, values.get(i));
            }
        }
        stmt.executeQuery();

    }
    public void insertarHorario(String consulta, String bar, String dia, Time apertura, Time cierre){
        
    }
}

