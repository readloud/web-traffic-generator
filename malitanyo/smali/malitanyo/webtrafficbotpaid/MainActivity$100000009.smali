.class Lmalitanyo/webtrafficbotpaid/MainActivity$100000009;
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
    name = "100000009"
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

    iput-object v4, v3, Lmalitanyo/webtrafficbotpaid/MainActivity$100000009;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/MainActivity$100000009;)Lmalitanyo/webtrafficbotpaid/MainActivity;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/MainActivity$100000009;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

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
    .line 219
    move-object v0, p0

    move-object v1, p1

    new-instance v6, Landroid/content/Intent;

    move-object v13, v6

    move-object v6, v13

    move-object v7, v13

    move-object v8, v0

    iget-object v8, v8, Lmalitanyo/webtrafficbotpaid/MainActivity$100000009;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    iget-object v8, v8, Lmalitanyo/webtrafficbotpaid/MainActivity;->context:Landroid/content/Context;

    :try_start_0
    const-string v9, "malitanyo.webtrafficbotpaid.more_app"

    invoke-static {v9}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v9

    invoke-direct {v7, v8, v9}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    move-object v3, v6

    .line 220
    move-object v6, v0

    iget-object v6, v6, Lmalitanyo/webtrafficbotpaid/MainActivity$100000009;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    move-object v7, v3

    invoke-virtual {v6, v7}, Lmalitanyo/webtrafficbotpaid/MainActivity;->startActivity(Landroid/content/Intent;)V

    return-void

    .line 219
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
