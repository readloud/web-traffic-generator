.class Lmalitanyo/webtrafficbotpaid/MainActivity$100000005;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmalitanyo/webtrafficbotpaid/MainActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x20
    name = "100000005"
.end annotation


# instance fields
.field private final this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;


# direct methods
.method constructor <init>(Lmalitanyo/webtrafficbotpaid/MainActivity;)V
    .locals 5

    move-object v0, p0

    move-object v1, p1

    move-object v3, v0

    invoke-direct {v3}, Ljava/lang/Object;-><init>()V

    move-object v3, v0

    move-object v4, v1

    iput-object v4, v3, Lmalitanyo/webtrafficbotpaid/MainActivity$100000005;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/MainActivity$100000005;)Lmalitanyo/webtrafficbotpaid/MainActivity;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/MainActivity$100000005;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    move-object v0, v3

    return-object v0
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 14
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/view/View;",
            ")V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Override;
    .end annotation

    .prologue
    .line 173
    move-object v0, p0

    move-object v1, p1

    new-instance v6, Landroid/content/Intent;

    move-object v13, v6

    move-object v6, v13

    move-object v7, v13

    move-object v8, v0

    iget-object v8, v8, Lmalitanyo/webtrafficbotpaid/MainActivity$100000005;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    iget-object v8, v8, Lmalitanyo/webtrafficbotpaid/MainActivity;->context:Landroid/content/Context;

    :try_start_0
    const-string v9, "malitanyo.webtrafficbotpaid.infobot"

    invoke-static {v9}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v9

    invoke-direct {v7, v8, v9}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    move-object v3, v6

    .line 174
    move-object v6, v3

    const-string v7, "TIT"

    const-string v8, "Web Traffic Bot [Paid]"

    invoke-virtual {v6, v7, v8}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v6

    .line 175
    move-object v6, v3

    const-string v7, "URL"

    const-string v8, "Web Traffic Bot Paid is app that can generate free traffic in your blog/website, Fast and easy to use ads free.\n\nRANDOM USER-AGENTS:\n\u2192 Our traffic bot have 10,000k+ Unique random user agent per submit.\n\nREFFERING URL:\n\u2192 Web traffic bot have 5,000k+ unique reffering url random.\n\nPOP-UP WINDOWS and JAVA\n\u2192 Using our traffic bot you can set enable or dis-able the popup windows of the target website. Pop-up Windows will show sometimes if the target website has content pop-up ads.\n\nTIME INTERVAL:\n\u2192 Using this Paid version you can set the time interval of bot between the next bot generate.\nNOTE:\n5000 = 5 seconds\n\nNOTE:\nWeb Traffic Bot Paid Dont Have features that can change the IP address. This Bot not Work some secure website."

    invoke-virtual {v6, v7, v8}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v6

    .line 176
    move-object v6, v0

    iget-object v6, v6, Lmalitanyo/webtrafficbotpaid/MainActivity$100000005;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    move-object v7, v3

    invoke-virtual {v6, v7}, Lmalitanyo/webtrafficbotpaid/MainActivity;->startActivity(Landroid/content/Intent;)V

    return-void

    .line 173
    :catch_0
    move-exception v6

    move-object v4, v6

    new-instance v6, Ljava/lang/NoClassDefFoundError;

    move-object v13, v6

    move-object v6, v13

    move-object v7, v13

    move-object v8, v4

    invoke-virtual {v8}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/lang/NoClassDefFoundError;-><init>(Ljava/lang/String;)V

    throw v6
.end method
