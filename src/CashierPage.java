import javafx.*;

public class CashierPage extends Application{

    @Override
    public void start(Stage primaryStage) throws Exception{
        FXMLLoader loader = new FXMLLoader();
        loader.setLocation(getClass().getResource("CashierPage.fxml"));
        Parent root = loader.load();
        Scene cashier_scene = new Scene(root);
        primaryStage.setScene(cashier_scene);
        primaryStage.setTitle("Cashier View");
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}
