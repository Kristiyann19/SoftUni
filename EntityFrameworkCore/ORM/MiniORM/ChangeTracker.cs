using System.Collections.Generic;
using System.Reflection;
using System.Linq;
using System;
using System.ComponentModel.DataAnnotations;

namespace MiniORM
{
    internal class ChangeTracker<T>
        where T : class , new()
    {
        private readonly List<T> addedEntities;
        private readonly List<T> removedEntities;
        private readonly List<T> allEntities;

        public ChangeTracker(IEnumerable<T> entities)
        {
            this.addedEntities = new List<T>();
            this.removedEntities = new List<T>();

            this.allEntities = CloneEntities(entities);
        }

        public IReadOnlyCollection<T> AllEntities => this.allEntities.AsReadOnly();

        public IReadOnlyCollection<T> AddedEntities => this.addedEntities.AsReadOnly();
        
        public IReadOnlyCollection<T> RemovedEntities => this.removedEntities.AsReadOnly();

        private static List<T> CloneEntities(IEnumerable<T> entities)
        {
            List<T> clonedEntities = new List<T>();

            PropertyInfo[] propertiesToClone = typeof(T).GetProperties()
                .Where(x => DbContext.AllowedSqlTypes.Contains(x.PropertyType)).ToArray();

            foreach (var entity in entities)
            {
                var clonedEntity = Activator.CreateInstance<T>();

                foreach (var property in propertiesToClone)
                {
                    var value = property.GetValue(entity);
                    property.SetValue(clonedEntity, value);
                }

                clonedEntities.Add(clonedEntity);
            }
            return clonedEntities;
        }

        public void Add(T item) => this.addedEntities.Add(item);

        public void Remove(T item) => this.removedEntities.Remove(item);


        public IEnumerable<T> GetModifiedEntities(DbSet<T> dbSet) 
        {
            var modifiedEntities = new List<T>();

            var primaryKeys = typeof(T).GetProperties()
                .Where(x => x.HasAttribute<KeyAttribute>()).ToArray();

            foreach (var proxyEntity in this.AllEntities)
            {
                var primaryKeyValues = GetPrimaryKeyValues(primaryKeys, proxyEntity).ToArray();

                var entity = dbSet.Entities
                    .Single(e => GetPrimaryKeyValues(primaryKeys, e).SequenceEqual(primaryKeyValues));

                var isModified = IsModified(proxyEntity, entity);
                if (isModified)
                {
                    modifiedEntities.Add(entity);
                }

            }
            return modifiedEntities;
        }

        private static IEnumerable<object> GetPrimaryKeyValues(IEnumerable<PropertyInfo> primaryKeys, T entity)
        {
            return primaryKeys.Select(pk => pk.GetValue(entity));
        }

        private static bool IsModified(T entity, T proxyEntity)
        {
            var monitoredProperties = typeof(T).GetProperties()
                .Where(pi => DbContext.AllowedSqlTypes.Contains(pi.PropertyType));

            var modifiedProperties = monitoredProperties
                .Where(pi => !Equals(pi.GetValue(entity), pi.GetValue(proxyEntity))).ToArray();

            var isModified = modifiedProperties.Any();

            return isModified;
        }
    }     
       
}