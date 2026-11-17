Connection connection = null;
try
 {

    // use the DriverManager to create 
    // a Connection object
    String dbUrl = 
        "jdbc:mysql://localhost:3306/petshop_schema";
    String username = "root";
    String password = "";
    connection = DriverManager.getConnection(
        dbUrl, username, password);
}
catch(SQLException e)
{
    for (Throwable t : e)
        t.printStackTrace();
}

