package examples;

import com.intuit.karate.junit5.Karate;

public class TestRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("EndToEnd.feature").relativeTo(getClass());
    }
}
