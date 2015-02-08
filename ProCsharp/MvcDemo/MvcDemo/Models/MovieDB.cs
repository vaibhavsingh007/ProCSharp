using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using System.ComponentModel.DataAnnotations;

namespace MvcDemo.Models
{
    public class MovieDB
    {
        // Adding the 'virtual' keyword to all the properties in the entity enables lazy loading and also
        // provides more features like change tracking mechanism.
        public virtual int ID { get; set; }
        public virtual string Title { get; set; }
        public virtual string Director { get; set; }
        public virtual string Review { get; set; }
        public virtual DateTime Date { get; set; }
        [DataType(DataType.Password)]
        public virtual string Test_Property { get; set; }
    }

    public class MovieDBContext : DbContext
    {
        public DbSet<MovieDB> Movies { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<MovieDB>().Property(r => r.Test_Property).HasColumnName("Test_Column");


            base.OnModelCreating(modelBuilder);
        }
    }
}