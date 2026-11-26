import java.io.InputStream;
import java.io.Reader;
import java.math.BigDecimal;
import java.net.URL;
import java.sql.*;
import java.util.Calendar;
import java.util.Map;

public class connector {
    // XAMPP default settings: root user with no password
    private static final String URL = "jdbc:mysql://localhost:3306/petshop";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public static Connection getConnection() {
        Connection connection = null;
        try {
            // Optional for JDBC 4.0+, but good for explicit loading
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Successfully connected to XAMPP MySQL database!");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found in classpath.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("⠀⠀⠀⠀⡏⠀⢀⣾⣏⠀⠀⠀⠀⠀⠈⣹⣷⣶⣯⠁⠀⠀⠀⠀⠀⣶⣶⣕⠈⠹⣎⢳⡾⠇⠀⠀⠀\n" + "⠀⠀⠀⠀⠃⠘⢸⣿⣟⢀⣴⣶⣾⣿⣾⣿⣿⣿⣿⣿⣿⣿⣶⣦⡲⣿⣿⣿⡇⠀⢻⣦⣀⠇⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⠀⣼⣿⣼⣷⡹⠟⠛⠻⣿⣿⣿⣿⣿⣿⠟⠉⠻⣿⣷⡽⣿⣿⣿⠀⠀⠉⠛⠃⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⡇⡴⠶⣦⠘⣿⣿⣷⡿⠇⣶⠟⣶⡈⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⢀⢿⣿⣿⣿⣿⡆⠳⣤⡿⠀⣯⠿⢿⡷⠀⠙⠦⠾⠁⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⢨⣼⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣾⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⡿⣵⣿⡿⠟⢛⣩⣀⡀⠓⠀⠀⠀⢠⣤⠀⠴⠄⢀⣬⣛⠿⣿⣿⣿⣿⠧⠀⠀⠀⠀⠀⠀\n" +"⠀⠀⠀⠀⣿⣿⡿⣡⣶⣿⣿⣿⣿⣷⣤⣀⠀⢀⣀⣀⣀⣾⣿⣿⣷⣷⡌⢻⣿⣏⢧⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⣿⡿⣰⣏⣹⣋⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⡙⣟⣹⡜⣿⣏⣯⠆⠀⠀⠀⠀⠀\n" +"⠀⠀⠀⠀⣿⢥⣿⡿⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣿⣿⣹⣿⡎⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⢿⡸⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⠿⠁⠀⠀⠀⠀⠀⠀\n" +"⠀⠀⠀⠀⠀⠃⢿⣿⣿⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⡟⠠⠀⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⢠⡌⠻⠿⢺⣿⣯⣛⢿⣿⡿⣿⣯⡿⣿⣿⣟⣿⣿⣟⣟⡰⣰⠀⠀⠀⠀⠀⠀⠀⠀⠀\n" +"⠀⠀⠀⠀⠀⢸⡀⠈⠂⠀⠀⠀⠉⠉⠙⠛⠛⠙⠛⠛⠉⠉⠈⠉⠉⠉⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⢸⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀\n" +"⠀⠀⠀⠀⠀⢸⠂⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⡼⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⢸⠀⠀⠀⢸⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⢣⢇⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀\n" +"⠀⠀⠀⠀⠀⢸⠅⠀⠀⣸⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢰⡷⠸⢹⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⢸⠂⠀⠀⣿⢸⡄⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣸⠃⡁⢸⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀!");
            e.printStackTrace();
        }
        return connection;
    }

    public static void main(String[] args) {
        getConnection();
        function1();
        }

    private static void function1() {
        try {
            String query1 = "SELECT * FROM Pet";
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery(query1);
            while(rs.next()){
                int PetId = rs.getInt("PetID");
                String PetName = rs.getString("PetName");
                String PetSpecies = rs.getString("PetSpecies");
                boolean PetInStore = rs.getBoolean("PetInStore");
                int LocationID = rs.getInt("LocationID");
                int CustomerID = rs.getInt("CustomerID");
                System.out.println(PetId+" "+PetName+" "+PetSpecies+" "+PetInStore+" "+LocationID+" "+CustomerID);
            }
        } catch (SQLException e) {
            System.out.println("⠀⠀⠀⠀⡏⠀⢀⣾⣏⠀⠀⠀⠀⠀⠈⣹⣷⣶⣯⠁⠀⠀⠀⠀⠀⣶⣶⣕⠈⠹⣎⢳⡾⠇⠀⠀⠀\n" + "⠀⠀⠀⠀⠃⠘⢸⣿⣟⢀⣴⣶⣾⣿⣾⣿⣿⣿⣿⣿⣿⣿⣶⣦⡲⣿⣿⣿⡇⠀⢻⣦⣀⠇⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⠀⣼⣿⣼⣷⡹⠟⠛⠻⣿⣿⣿⣿⣿⣿⠟⠉⠻⣿⣷⡽⣿⣿⣿⠀⠀⠉⠛⠃⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⡇⡴⠶⣦⠘⣿⣿⣷⡿⠇⣶⠟⣶⡈⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⢀⢿⣿⣿⣿⣿⡆⠳⣤⡿⠀⣯⠿⢿⡷⠀⠙⠦⠾⠁⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⢨⣼⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣾⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⡿⣵⣿⡿⠟⢛⣩⣀⡀⠓⠀⠀⠀⢠⣤⠀⠴⠄⢀⣬⣛⠿⣿⣿⣿⣿⠧⠀⠀⠀⠀⠀⠀\n" +"⠀⠀⠀⠀⣿⣿⡿⣡⣶⣿⣿⣿⣿⣷⣤⣀⠀⢀⣀⣀⣀⣾⣿⣿⣷⣷⡌⢻⣿⣏⢧⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⣿⡿⣰⣏⣹⣋⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⡙⣟⣹⡜⣿⣏⣯⠆⠀⠀⠀⠀⠀\n" +"⠀⠀⠀⠀⣿⢥⣿⡿⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣿⣿⣹⣿⡎⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⢿⡸⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⠿⠁⠀⠀⠀⠀⠀⠀\n" +"⠀⠀⠀⠀⠀⠃⢿⣿⣿⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⡟⠠⠀⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⢠⡌⠻⠿⢺⣿⣯⣛⢿⣿⡿⣿⣯⡿⣿⣿⣟⣿⣿⣟⣟⡰⣰⠀⠀⠀⠀⠀⠀⠀⠀⠀\n" +"⠀⠀⠀⠀⠀⢸⡀⠈⠂⠀⠀⠀⠉⠉⠙⠛⠛⠙⠛⠛⠉⠉⠈⠉⠉⠉⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⢸⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀\n" +"⠀⠀⠀⠀⠀⢸⠂⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⡼⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⢸⠀⠀⠀⢸⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⢣⢇⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀\n" +"⠀⠀⠀⠀⠀⢸⠅⠀⠀⣸⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢰⡷⠸⢹⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⢸⠂⠀⠀⣿⢸⡄⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣸⠃⡁⢸⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀!");
            e.printStackTrace();
        }

    }
    private static void function2() {
        try {
            String query2 = "insert into Job (JobID, Job Name) values(?, ?);";
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            Statement statement = conn.createStatement();
            statement.setString(1, 4);
            statement.setString(2, "Marketing");
            ResultSet rs = statement.executeQuery(query2);
            System.out.println("Inserted")
            
        } catch (SQLException e) {
            System.out.println("⠀⠀⠀⠀⡏⠀⢀⣾⣏⠀⠀⠀⠀⠀⠈⣹⣷⣶⣯⠁⠀⠀⠀⠀⠀⣶⣶⣕⠈⠹⣎⢳⡾⠇⠀⠀⠀\n" + "⠀⠀⠀⠀⠃⠘⢸⣿⣟⢀⣴⣶⣾⣿⣾⣿⣿⣿⣿⣿⣿⣿⣶⣦⡲⣿⣿⣿⡇⠀⢻⣦⣀⠇⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⠀⣼⣿⣼⣷⡹⠟⠛⠻⣿⣿⣿⣿⣿⣿⠟⠉⠻⣿⣷⡽⣿⣿⣿⠀⠀⠉⠛⠃⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⡇⡴⠶⣦⠘⣿⣿⣷⡿⠇⣶⠟⣶⡈⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⢀⢿⣿⣿⣿⣿⡆⠳⣤⡿⠀⣯⠿⢿⡷⠀⠙⠦⠾⠁⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⢨⣼⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣾⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⡿⣵⣿⡿⠟⢛⣩⣀⡀⠓⠀⠀⠀⢠⣤⠀⠴⠄⢀⣬⣛⠿⣿⣿⣿⣿⠧⠀⠀⠀⠀⠀⠀\n" +"⠀⠀⠀⠀⣿⣿⡿⣡⣶⣿⣿⣿⣿⣷⣤⣀⠀⢀⣀⣀⣀⣾⣿⣿⣷⣷⡌⢻⣿⣏⢧⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⣿⡿⣰⣏⣹⣋⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⡙⣟⣹⡜⣿⣏⣯⠆⠀⠀⠀⠀⠀\n" +"⠀⠀⠀⠀⣿⢥⣿⡿⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣿⣿⣹⣿⡎⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⢿⡸⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⠿⠁⠀⠀⠀⠀⠀⠀\n" +"⠀⠀⠀⠀⠀⠃⢿⣿⣿⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⡟⠠⠀⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⢠⡌⠻⠿⢺⣿⣯⣛⢿⣿⡿⣿⣯⡿⣿⣿⣟⣿⣿⣟⣟⡰⣰⠀⠀⠀⠀⠀⠀⠀⠀⠀\n" +"⠀⠀⠀⠀⠀⢸⡀⠈⠂⠀⠀⠀⠉⠉⠙⠛⠛⠙⠛⠛⠉⠉⠈⠉⠉⠉⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⢸⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀\n" +"⠀⠀⠀⠀⠀⢸⠂⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⡼⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⢸⠀⠀⠀⢸⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⢣⢇⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀\n" +"⠀⠀⠀⠀⠀⢸⠅⠀⠀⣸⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢰⡷⠸⢹⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀\n" + "⠀⠀⠀⠀⠀⢸⠂⠀⠀⣿⢸⡄⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣸⠃⡁⢸⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀!");
            e.printStackTrace();
        }

    }

    ;

    }

//⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⣤⣤⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⢠⣾⣵⣾⣿⣿⣷⠀⠀⠀⠀⠀⣀⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⡿⠟⠋⣉⣦⣄⢀⢔⡡⠒⠀⢲⣣⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⡠⠔⠒⠒⠂⢄⣧⣤⣶⣿⣿⡿⠛⠈⠺⢄⡀⠈⢻⢿⡄⠀⠀⠀⠀⠀⠀
//⠀⠀⢰⠁⡔⠉⠁⠉⢲⡟⠉⠉⢀⣀⡀⠀⢀⢖⡓⠺⣦⢎⠜⠁⠀⠀⠀⠀⠀⠀
//⠀⠀⠈⢆⠹⣄⠀⠀⣌⠇⢀⡞⢡⠔⠒⠁⠆⢪⠖⣲⣌⠆⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠑⠌⣁⠖⠋⠀⡼⠀⡕⠉⡽⣆⠀⠸⣀⣫⣼⣼⡶⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⢸⡄⠀⣠⠇⠀⡄⢀⣣⣽⣠⣴⣾⡯⠀⠈⢧⡂⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⢠⠀⠈⠑⠒⠬⢾⠋⠉⠀⠈⠉⠛⠁⠀⠀⠜⠇⠀⠀⠀⠀⡀⠀
//⢀⡀⠀⠀⠀⠀⠈⢤⣀⡠⠯⠶⢼⣀⠀⠀⠀⣀⠤⠀⠒⣹⢸⠀⠀⣀⡴⠋⠀⠀
//⠐⠠⢉⠑⠲⣤⣄⣀⠸⣀⠀⠀⠈⠪⡊⠋⠣⠔⠀⠈⡉⠄⢸⢒⠞⠀⠀⠀⠀⠀
//⡐⣄⠀⠀⠀⠀⠉⠂⡩⢶⣷⣦⣄⡀⠈⠑⠂⢒⠊⠁⢀⣠⡎⠹⠀⠀⠀⠀⢀⠈
//⡑⢌⠳⣄⠀⠀⢠⠊⠀⠘⣆⣤⣿⣿⣷⣦⣤⣼⣶⣾⣿⡿⠁⡇⠀⠀⠀⡔⠁⣠
//⢣⠀⠑⢄⡂⢠⡁⠀⠀⠀⣸⠿⠻⣿⣧⡼⢿⣿⣿⡛⢿⡄⠀⠃⠀⠀⡸⡡⠊⠀
//⠀⢹⡄⠀⠉⠲⡇⠀⠀⡘⢸⣠⣾⠟⢅⠀⠀⠟⢯⣓⣠⡇⠀⠸⣄⠀⢠⠃⠀⠀
// "Great job superstar!!!!"