using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Machine_Problem
{
    public class Clear
    {
        public static void clearForm(Page pageObject)
        {
            foreach (Control ctrl in pageObject.Form.FindControl("ContentPlaceHolder1").Controls)
            {
                if (ctrl is TextBox) 
                    ((TextBox)ctrl).Text = string.Empty;
                if (ctrl is DropDownList)
                    ((DropDownList)ctrl).ClearSelection();
            }
        }
    }
}