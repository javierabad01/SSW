import java.sql.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/Registrar"})
public class Registrar extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            // Patrón para validar el email
            Pattern pattern = Pattern
                .compile("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
                        + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
            // Obtener los datos del formulario
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String passwordRepeat = request.getParameter("passwordRepeat");

            Matcher mather = pattern.matcher(email);
            String mensajeError="";

            // Validar el email
            if (mather.find() == false) {
                mensajeError=("El email ingresado no es válido.");
request.getSession().setAttribute("mensajeError", mensajeError);
            }
            // Validar que las contraseñas coincidan
            else if (!password.equals(passwordRepeat)) {  
                mensajeError=("Las contraseñas no coinciden!");
                request.getSession().setAttribute("mensajeError", mensajeError);
            }
            // Validar que la contraseña no esté vacía
            else if(password.equals("")){
                mensajeError=("El campo de contraseña esta vacío.");
request.getSession().setAttribute("mensajeError", mensajeError);
            }
            // Verificar si el usuario ya existe en la base de datos
            else{
                int existeUsuario= verificarUsuario(email, username);
                if (existeUsuario!=0){
                    switch (existeUsuario) {
                        case 1:
                            mensajeError=("Un usuario existe con ese correo.");
                            break;
                        case 2:
                            mensajeError=("Ya ha sido utilizado ese nombre de usuario.");
                            break;
                        default:
                            mensajeError=("Correo y nombre de usuario ya registrados.");
                            break;
                    }
request.getSession().setAttribute("mensajeError", mensajeError);
                }
                else{
                    insertarUsuario(email, username, password);
                    request.getSession().setAttribute("successMessage", "Registro completado con éxito!");
                    request.getSession().setAttribute("username", username);

                }
            }
        }
        catch(Exception ex){
            mostrarError(ex.getMessage(), response.getWriter());
        }
    }

    private void insertarUsuario(String email, String username, String password) {
        try {       
            System.out.println("Entras!");
            // Establecer la conexión a la base de datos
            Class.forName("org.mariadb.jdbc.Driver");
            System.out.println("Connected to database!");
            String url = "jdbc:mariadb://localhost:3306/mysql";
            String user = "root";
            String passwd = "root";
            Connection conn = DriverManager.getConnection(url, user, passwd);

            // Insertar el usuario en la tabla usuarios
            String sql = "INSERT INTO users (email, username, password) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, username);
            stmt.setString(3, password);
            int rows = stmt.executeUpdate();

            // Cerrar la conexión a la base de datos
            conn.close();

            // Generar respuesta
            
            } catch (Exception ex) {
                
            }
    }
private int verificarUsuario(String email, String username) {
    int existeUsuario = 0;
    try {
        // Establecer la conexión a la base de datos
        Class.forName("org.mariadb.jdbc.Driver");
        String url = "jdbc:mariadb://localhost:3306/mysql";
        String user = "root";
        String passwd = "root";
        Connection conn = DriverManager.getConnection(url, user, passwd);

        // Verificar si el correo ya está registrado
        String sql = "SELECT COUNT(*) FROM users WHERE email=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            int count = rs.getInt(1);
            if (count > 0) {
                existeUsuario = 1;
            }
        }

        // Verificar si el nombre de usuario ya está registrado
        sql = "SELECT COUNT(*) FROM users WHERE username=?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        rs = stmt.executeQuery();
        if (rs.next()) {
            int count = rs.getInt(1);
            if (count > 0) {
                existeUsuario = existeUsuario == 1 ? 3 : 2;
            }
        }

        // Cerrar la conexión a la base de datos
        conn.close();
    } catch (Exception ex) {
        System.out.println(ex.getMessage());
    }
    return existeUsuario;
}

private void mostrarError(String mensaje, PrintWriter out) {
    out.println("<!DOCTYPE HTML>");
    out.println("<html>");
    out.println("<head>");
    out.println("<title>Error</title>");
    out.println("</head>");
    out.println("<body>");
    out.println("<h1>Error</h1>");
    out.println("<p>" + mensaje + "</p>");
    out.println("</body>");
    out.println("</html>");
}

protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    processRequest(request, response);
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // Call the processRequest method to process the form data
    processRequest(request, response);

    // Check if there is an error
    String mensajeError = (String) request.getSession().getAttribute("mensajeError");
    if (mensajeError != null && !mensajeError.isEmpty()) {
        // If there is an error, redirect back to the JSP page
        response.sendRedirect("registro.jsp");
    } else {
        // If there is no  error, go to the success page
        // Guardar información del usuario en la sesión
        response.sendRedirect("registro.jsp");
    }
}
}