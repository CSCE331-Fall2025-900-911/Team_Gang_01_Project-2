import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.GridPane;
import javafx.stage.Stage;

public class LoginPage extends Application {

    @Override
    public void start(Stage primaryStage) {
        primaryStage.setTitle("Login Page");

        // Create buttons
        Button zeroButton = new Button("0");
        Button oneButton = new Button("1");
        Button twoButton = new Button("2");
        Button threeButton = new Button("3");
        Button fourButton = new Button("4");
        Button fiveButton = new Button("5");
        Button sixButton = new Button("6");
        Button sevenButton = new Button("7");
        Button eightButton = new Button("8");
        Button nineButton = new Button("9");

        // Layout using GridPane instead of SpringLayout
        GridPane grid = new GridPane();
        grid.setPadding(new Insets(10));
        grid.setHgap(10);
        grid.setVgap(10);

        // Add buttons to grid in a 4x3 style (like keypad)
        grid.add(oneButton, 0, 0);
        grid.add(twoButton, 1, 0);
        grid.add(threeButton, 2, 0);

        grid.add(fourButton, 0, 1);
        grid.add(fiveButton, 1, 1);
        grid.add(sixButton, 2, 1);

        grid.add(sevenButton, 0, 2);
        grid.add(eightButton, 1, 2);
        grid.add(nineButton, 2, 2);

        grid.add(zeroButton, 1, 3);

        Scene scene = new Scene(grid, 300, 400);
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}
