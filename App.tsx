/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import { NewAppScreen } from '@react-native/new-app-screen';
import { Alert, Button, StatusBar, StyleSheet, useColorScheme, View } from 'react-native';

const App = () => {

  const handleUserLogin = () => {
    CleverTap.onUserLogin({
      Name: 'React-Test1',
      Identity: '111020089',
      Email: 'reacttest1@gmail.com',
      custom1: 43,
    });
    Alert.alert('User login event sent to CleverTap');

  CleverTap.setDebugLevel(3);

  };

  const handleEvent1 = () => {
    CleverTap.recordEvent('Button2_Clicked', { screen: 'Home', value: 100 });
    Alert.alert('Event "Button2_Clicked" sent to CleverTap');
  };

  const handleEvent2 = () => {
    CleverTap.recordEvent('Button3_Clicked', { screen: 'Home', value: 200 });
    Alert.alert('Event "Button3_Clicked" sent to CleverTap');
  };

  const handlePress = (buttonName: string) => {
    Alert.alert(`${buttonName} pressed`);
  };

  const CleverTap = require('clevertap-react-native');
  
  return (
    <View style={styles.container}>
      <View style={styles.buttonWrapper}>
        <Button title="User Profile" onPress={handleUserLogin} />
      </View>
      <View style={styles.buttonWrapper}>
        <Button title="Custom Event" onPress={handleEvent1} />
      </View>
      <View style={styles.buttonWrapper}>
        <Button title="Push Notification" onPress={handleEvent2} />
      </View>
      <View style={styles.buttonWrapper}>
        <Button title="Inapp Notification" onPress={() => handlePress('Button 4')} />
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center', // center vertically
    alignItems: 'stretch', // make buttons take full width
    paddingHorizontal: 20,
    backgroundColor: '#fff',
  },
  buttonWrapper: {
    marginVertical: 10, // spacing between buttons
  },
});

export default App;
