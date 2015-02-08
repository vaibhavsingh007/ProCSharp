using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace LastModifiedAttribute
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method,
        AllowMultiple = true, Inherited = false)]
    public class LastModifiedAttrib : Attribute
    {
        private DateTime dateModified;
        private string nameOfDev;
        private string changesMade;
        private string comments;

        public LastModifiedAttrib(string dateModified, string nameOfDev, string changesMade)
        {
            this.dateModified = DateTime.Parse(dateModified);
            this.nameOfDev = nameOfDev;
            this.changesMade = changesMade;
        }

        public DateTime DateModified
        {
            get { return dateModified; }
        }
        public string NameOfDev
        {
            get { return nameOfDev; }
        }
        public string ChangesMade
        {
            get { return changesMade; }
        }
        public string Comments
        {
            get
            {
                return comments;
            }
            set
            {
                comments = value;
            }
        }
    }

    [AttributeUsage(AttributeTargets.Assembly)]
    public class SupportsLastModifiedAttrib : Attribute
    { }
}
