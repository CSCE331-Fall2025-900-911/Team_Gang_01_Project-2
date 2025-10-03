import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;

import java.net.URL;


public class ManagerPage extends Application{
    public static void main(String[] args) {    
      launch(args);
    }   

    @Override
    public void start(Stage primaryStage) throws Exception {
        FXMLLoader loader = new FXMLLoader();
        URL fxmlLocation = getClass().getResource("ManagerPage.fxml");
        loader.setLocation(fxmlLocation);
        AnchorPane root = loader.load();
        Scene scene = new Scene(root);
        primaryStage.setScene(scene);
    }

}   
