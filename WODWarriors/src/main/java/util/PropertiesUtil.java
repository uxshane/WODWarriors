package util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class PropertiesUtil {

	private Properties properties;

	public PropertiesUtil(String propertiesFileName) {
		properties = new Properties();
		try (InputStream input = getClass().getClassLoader().getResourceAsStream("config/mybatis/" + propertiesFileName)) {
			if (input == null) {
				System.out.println("Sorry, unable to find " + propertiesFileName);
				return;
			}
			properties.load(input);
		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}

	public String getProperty(String key) {
		return properties.getProperty(key);
	}

}
