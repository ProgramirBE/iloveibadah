﻿using IbadahLover.Domain.Common;
using IbadahLover.Domain.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IbadahLover.Domain
{
    //Database Table UserAccount
    public class UserAccount
    {
        public int Id { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        [ForeignKey("ProfilePictureType")]
        public int? ProfilePictureTypeId { get; set; }
        public ProfilePictureType? ProfilePictureType { get; set; }
        public string? PasswordHash { get; set; }
        public OAuthProviderType? OAuthProvider { get; set; }
        public string? OAuthId { get; set; }
        public string? CurrentLocation { get; set; }
        public int? TotalWarnings { get; set; }
        public bool? EmailConfirmed { get; set; }
        public bool? IsPermanentlyBanned { get; set; }
        //[DataType(DataType.Date)]
        //public DateTime CreatedOn { get; set; }
        //[DataType(DataType.Date)]
        //public DateTime LastModifiedOn { get; set; }
        //[ForeignKey("LastModifiedByUserAccount")]
        //public int? LastModifiedBy { get; set; }
        //public UserAccount? LastModifiedByUserAccount { get; set; } // Navigation property
    }
}
