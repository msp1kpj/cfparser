<cfcomponent displayame="CustomOptInGateway" output="false" initmethod="init" accessors="true" extends="_BaseGateway">

    <cffunction name="init" access="public" output="false" returntype="CustomOptInGateway" hint ="Return gateway object for custom opt in data layer">
        <cfreturn this />
    </cffunction>

    <cffunction name="registerMemberCustomOptIn" access="public" returntype="void" output="false" hint="Run insert or update query to save custom member opt in information">
        <cfargument name="memberId" type="string" required="true" />
        <cfargument name="customOptInKey" type="string" required="false" default="" />
        <cfargument name="partnerId" type="string" required="false" default="0" />

        <cfquery>
            DECLARE @MemberID int,
                @CustomOptInKey varchar(100),
                @CustomOptInID int,
                @PartnerID int

            SET @MemberID = <cfqueryparam value="#arguments.memberId#" cfsqltype="cf_sql_varchar" />
            SET @CustomOptInKey = <cfqueryparam value="#arguments.customOptInKey#" cfsqltype="cf_sql_varchar" />
            SET @PartnerID = <cfqueryparam value="#arguments.partnerId#" cfsqltype="cf_sql_varchar" />

            SET @CustomOptInID = ISNULL((SELECT TOP 1 CustomOptInID FROM CustomOptIn WITH(NOLOCK) WHERE CustomOptInKey = @CustomOptInKey),0)

            IF (@CustomOptInID > 0)
            BEGIN
                IF NOT EXISTS(SELECT CustomOptInID FROM CustomOptInMember WITH(NOLOCK) WHERE MemberID = @MemberID AND CustomOptInID = @CustomOptInID)
                BEGIN
                    INSERT INTO CustomOptInMember (MemberID, CustomOptInID, PartnerID)
                    VALUES (@MemberID, @CustomOptInID, @PartnerID)
                END
                ELSE
                BEGIN
                    UPDATE CustomOptInMember
                    SET IsActive = 1,
                        PartnerID = @PartnerID,
                        UpdateDate = getDate()
                    WHERE MemberID = @MemberID
                        AND CustomOptInID = @CustomOptInID
                END
            END
        </cfquery>
    </cffunction>

</cfcomponent>
