using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Dynamic;
using System.Collections;
using System.Web.Script.Serialization;
using System.Collections.ObjectModel;
using System.Text;
using System.Security.Cryptography;
using System.IO;

namespace ProCsharp.Chapters
{
    public partial class Security : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        /* 'Comment from the article': To use our converter we create a serializer, register our 
         * converter with it and then call the deserialize method. 
         * Now we can use our standard “dot” notation to traverse our JSON 
         * object without the need for external libraries and in under 100 lines of code. Now JSON 
         * in .NET feels a lot like JSON in JavaScript. . . 
         * When I heard that C# was getting this dynamic stuff I was unsure of its power and relevance, 
         * now I have “seen the light” and can really see where this was a great addition to the language. 
         */
        static string DeserializeJson()
        {
            string json;
            StringBuilder returnString = new StringBuilder();
            using (System.IO.StreamReader jsonFile = new System.IO.StreamReader(Constants.AppDataPath + @"\JsonData.txt"))
            {
                json = jsonFile.ReadToEnd();
            }

            JavaScriptSerializer jss = new JavaScriptSerializer();
            jss.RegisterConverters(new JavaScriptConverter[] { new DynamicJsonConverter() });
            dynamic glossaryEntry = jss.Deserialize(json, typeof(object)) as dynamic;
            returnString.Append("glossaryEntry.glossary.title: " + glossaryEntry.glossary.title);
            returnString.Append("glossaryEntry.glossary.GlossDiv.title: " + glossaryEntry.glossary.GlossDiv.title);
            returnString.Append("glossaryEntry.glossary.GlossDiv.GlossList.GlossEntry.ID: " + glossaryEntry.glossary.GlossDiv.GlossList.GlossEntry.ID);
            returnString.Append("glossaryEntry.glossary.GlossDiv.GlossList.GlossEntry.GlossDef.para: " + glossaryEntry.glossary.GlossDiv.GlossList.GlossEntry.GlossDef.para);

            foreach (var also in glossaryEntry.glossary.GlossDiv.GlossList.GlossEntry.GlossDef.GlossSeeAlso)
            {
                returnString.Append("glossaryEntry.glossary.GlossDiv.GlossList.GlossEntry.GlossDef.GlossSeeAlso: " + also);
            }
            return returnString.ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            TextBox1.Text = DeserializeJson();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            TextBox2.Text = EncryptedSignature.RunEncryptedSignature();
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            KeyExchangeAndSecureTransfer.RunKeyExchangeAndSecureTransfer();
            TextBox2.Text = KeyExchangeAndSecureTransfer.ReturnString;
        }


    }

    // The first step is to create our dynamic object.
    public class DynamicJsonObject : DynamicObject
    {
        private IDictionary<string, object> Dictionary { get; set; }
        public DynamicJsonObject(IDictionary<string, object> dictionary)
        {
            Dictionary = dictionary;
        }

        public override bool TryGetMember(GetMemberBinder binder, out object result)
        {
            result = this.Dictionary[binder.Name];
            if (result is IDictionary<string, object>)
            {
                result = new DynamicJsonObject(result as IDictionary<string, object>);
            }
            else if (result is ArrayList)
            {
                result = new List<object>((result as ArrayList).ToArray());
            }
            return this.Dictionary.ContainsKey(binder.Name);
        }
    }

    // Now we need an implementation of the JavaScriptConverter
    public class DynamicJsonConverter : JavaScriptConverter
    {
        public override object Deserialize(IDictionary<string, object> dictionary, Type type, JavaScriptSerializer serializer)
        {
            if (dictionary == null)
                throw new ArgumentNullException("dictionary");
            if (type is object)
            {
                return new DynamicJsonObject(dictionary);
            }
            return null;
        }

        public override IDictionary<string, object> Serialize(object obj, JavaScriptSerializer serializer)
        {
            throw new NotImplementedException();
        }

        public override IEnumerable<Type> SupportedTypes
        {
            get { return new ReadOnlyCollection<Type>(new List<Type>(new Type[] { typeof(object) })); }
        }
    }

    // Encryption

    public class EncryptedSignature
    {
        internal static CngKey aliceKeySignature;
        internal static byte[] alicePubKeyBlob;

        /*CreateKeys() is the method that creates a new key pair for Alice. This key pair is stored in a static field
        so it can be accessed from the other methods. The Create() method of CngKey gets the algorithm as an
        argument to define a key pair for the algorithm. With the Export() method, the public key of the key
        pair is exported. This public key can be given to Bob for the verification of the signature. Alice keeps the
        private key. Instead of creating a key pair with the CngKey class, you can open existing keys that are
        stored in the key store. Usually Alice would have a certificate containing a key pair in her private store,
        and the store could be accessed with CngKey.Open()
         */

        public static string RunEncryptedSignature()
        {
            string returnString;

            CreateKeys();

            byte[] aliceData = Encoding.UTF8.GetBytes("Alice");
            byte[] aliceSignature = CreateSignature(aliceData, aliceKeySignature);
            returnString = String.Format("Alice created signature: {0}", Convert.ToBase64String(aliceSignature));

            if (VerifySignature(aliceData, aliceSignature, alicePubKeyBlob))
            {
                returnString += "\nAlice's signature verified successfully!";
            }
            return returnString;
        }

        private static void CreateKeys()
        {
            aliceKeySignature = CngKey.Create(CngAlgorithm.ECDsaP256);
            alicePubKeyBlob = aliceKeySignature.Export(CngKeyBlobFormat.GenericPublicBlob);
        }

        private static byte[] CreateSignature(byte[] data, CngKey key)
        {
            ECDsaCng signingAlgo = new ECDsaCng(key);
            byte[] signature = signingAlgo.SignData(data);
            signingAlgo.Clear();

            return signature;
        }

        private static bool VerifySignature(byte[] data, byte[] signature, byte[] pubKey)
        {
            bool retValue = false;
            using (CngKey key = CngKey.Import(pubKey, CngKeyBlobFormat.GenericPublicBlob))
            {
                ECDsaCng signingAlgo = new ECDsaCng(key);
                retValue = signingAlgo.VerifyData(data, signature);
                signingAlgo.Clear();
            }
            return retValue;
        }
    }

    // Demostrating key exchange and secure transfer.

    // We will now exchange a symmetric key for a secure transfer by using the Diffie Hellman algorithm.
    public class KeyExchangeAndSecureTransfer
    {
        static CngKey aliceKey;
        static CngKey bobKey;
        static byte[] alicePubKeyBlob;
        static byte[] bobPubKeyBlob;
        public static string ReturnString { get; set; }    // So we can display it on the webpage.

        public static void RunKeyExchangeAndSecureTransfer()
        {
            CreateKeys();
            byte[] encryptedData = AliceSendsData("Secret message from Alice");
            BobReceivesData(encryptedData);
        }

        private static void CreateKeys()
        {
            aliceKey = CngKey.Create(CngAlgorithm.ECDiffieHellmanP256);
            bobKey = CngKey.Create(CngAlgorithm.ECDiffieHellmanP256);
            alicePubKeyBlob = aliceKey.Export(CngKeyBlobFormat.EccPublicBlob);
            bobPubKeyBlob = bobKey.Export(CngKeyBlobFormat.EccPublicBlob);
        }

        private static byte[] AliceSendsData(string message)
        {
            ReturnString = string.Format("Alice sends message: {0}", message);

            // the string that contains text characters is converted to a byte array by using the Encoding class.
            byte[] rawData = Encoding.UTF8.GetBytes(message);
            byte[] encryptedData = null;

            // An ECDiffieHellmanCng object is created and initialized with the key pair from Alice.
            ECDiffieHellmanCng aliceAlgo = new ECDiffieHellmanCng(aliceKey);

            // Alice creates a symmetric key by using her key pair and the public key from Bob calling
            // the method DeriveKeyMaterial() . The returned symmetric key is used with the symmetric algorithm
            // AES to encrypt the data.
            using (CngKey bobPubKey = CngKey.Import(bobPubKeyBlob, CngKeyBlobFormat.EccPublicBlob))
            {
                byte[] symmKey = aliceAlgo.DeriveKeyMaterial(bobPubKey);
                ReturnString += string.Format("\nAlice creates this symmetric key with Bob's" +
                                " public key information: {0}", Convert.ToBase64String(symmKey));

                // AesCryptoServiceProvider requires the key and an initialization vector (IV).
                // The IV is generated dynamically from the method GenerateIV().
                AesCryptoServiceProvider aes = new AesCryptoServiceProvider();
                aes.Key = symmKey;
                aes.GenerateIV();

                // The IV is stored as first content in the memory stream followed by the encrypted data where the
                //CryptoStream class uses the encryptor created by the AesCryptoServiceProvider class. Before
                //the encrypted data is accessed from the memory stream, the crypto stream must be closed. Otherwise,
                //end bits would be missing from the encrypted data.
                using (ICryptoTransform encryptor = aes.CreateEncryptor())
                using (MemoryStream ms = new MemoryStream())
                {
                    // create CryptoStream and encrypt data to send
                    CryptoStream cs = new CryptoStream(ms, encryptor, CryptoStreamMode.Write);

                    // write initialization vector not encrypted
                    ms.Write(aes.IV, 0, aes.IV.Length);
                    cs.Write(rawData, 0, rawData.Length);
                    cs.Close();
                    encryptedData = ms.ToArray();
                }
                aes.Clear();

                ReturnString += String.Format("\nAlice's message is encrypted: {0}",
                                                Convert.ToBase64String(encryptedData));

                return encryptedData;
            }
        }

        /*Bob receives encrypted data in the argument of the method BobReceivesData() . First, the
        unencrypted initialization vector must be read. The BlockSize property of the class
        AesCryptoServiceProvider returns the number of bits for a block. The number of bytes can be
        calculated by doing a divide by 8, and the fastest way to do this is by doing a bit shift of 3 bits. Shifting
        by 1 bit is a division by 2, 2 bits by 4, and 3 bits by 8. With the for loop, the first bytes of the raw bytes
        that contain the IV unencrypted are written to the array iv . Next, an ECDiffieHellmanCng object is
        instantiated with the key pair from Bob. Using the public key from Alice, the symmetric key is returned
        from the method DeriveKeyMaterial() . Comparing the symmetric keys created from Alice and Bob
        shows that the same key value gets created. Using this symmetric key and the initialization vector, the
        message from Alice can be decrypted with the AesCryptoServiceProvider class.
         */
        private static void BobReceivesData(byte[] encryptedData)
        {
            ReturnString += String.Format("\n\nBob receives encrypted data");
            byte[] rawData = null;
            AesCryptoServiceProvider aes = new AesCryptoServiceProvider();
            int nBytes = aes.BlockSize >> 3;
            byte[] iv = new byte[nBytes];
            for (int i = 0; i < iv.Length; i++)
                iv[i] = encryptedData[i];
            ECDiffieHellmanCng bobAlgorithm = new ECDiffieHellmanCng(bobKey);
            using (CngKey alicePubKey = CngKey.Import(alicePubKeyBlob,
            CngKeyBlobFormat.EccPublicBlob))
            {
                byte[] symmKey = bobAlgorithm.DeriveKeyMaterial(alicePubKey);
                ReturnString += String.Format("\nBob creates this symmetric key with " +
                "Alice's public key information: {0}",
                Convert.ToBase64String(symmKey));
                aes.Key = symmKey;
                aes.IV = iv;
                using (ICryptoTransform decryptor = aes.CreateDecryptor())
                using (MemoryStream ms = new MemoryStream())
                {
                    CryptoStream cs = new CryptoStream(ms, decryptor,
                    CryptoStreamMode.Write);
                    cs.Write(encryptedData, nBytes, encryptedData.Length - nBytes);
                    cs.Close();
                    rawData = ms.ToArray();
                    ReturnString += String.Format("\nBob decrypts message to: {0}",
                    Encoding.UTF8.GetString(rawData));
                }
                aes.Clear();
            }
        }
    }
}

