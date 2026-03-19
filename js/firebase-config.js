/**
 * Firebase Configuration
 * Replace with your Firebase project credentials
 */
const firebaseConfig = {
    apiKey: 'AIzaSyBZn5av7P66y7VBpR2wgVb7DtOtnsfMYFA',
    authDomain: 'coursepool-488520.firebaseapp.com',
    projectId: 'coursepool-488520',
    storageBucket: 'coursepool-488520.firebasestorage.app',
    messagingSenderId: '1084097792660',
    appId: '1:1084097792660:web:da5979d939420326598281',
    measurementId: 'G-1FM4Z5WDPV',
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);

const auth = firebase.auth();
const storage = typeof firebase.storage === 'function' ? firebase.storage() : null;
const googleProvider = new firebase.auth.GoogleAuthProvider();
