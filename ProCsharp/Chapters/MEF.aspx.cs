﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;

namespace ProCsharp.Chapters
{
    public partial class MEF : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Process.Start("C:\\users\\Vaibhav\\Documents\\Visual Studio 2010\\Projects\\ASPdotnet\\ProCsharp\\ProCsharp\\SimpleMEFCalculator\\SimpleMEFCalculator\\bin\\Debug\\SimpleMEFCalculator.exe");
        }
    }
}