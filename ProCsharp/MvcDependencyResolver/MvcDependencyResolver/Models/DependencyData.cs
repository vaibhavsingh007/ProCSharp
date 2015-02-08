using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.WebPages.Html;
using System.ComponentModel.DataAnnotations;


namespace MvcDependencyResolver.Models
{
    public class DependencyData
    {
        private List<SelectListItem> _vertices = new List<SelectListItem>();

        [Required(ErrorMessage = "Please select a vertex")]
        public string SelectedVertex { get; set; }

        public List<SelectListItem> Vertices
        {
            get
            {
                _vertices.Add(new SelectListItem() { Text = "A", Value = "A" });
                _vertices.Add(new SelectListItem() { Text = "B", Value = "B" });
                _vertices.Add(new SelectListItem() { Text = "C", Value = "C" });
                _vertices.Add(new SelectListItem() { Text = "D", Value = "D" });
                return _vertices;
            }
        }
            
        public string Edges { get; set; }
    }
}