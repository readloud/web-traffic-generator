.class Lmalitanyo/webtrafficbotpaid/more_app$100000000;
.super Ljava/lang/Object;
.source "more_app.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmalitanyo/webtrafficbotpaid/more_app;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x20
    name = "100000000"
.end annotation


# instance fields
.field private final this$0:Lmalitanyo/webtrafficbotpaid/more_app;


# direct methods
.method constructor <init>(Lmalitanyo/webtrafficbotpaid/more_app;)V
    .locals 5

    move-object v0, p0

    move-object v1, p1

    move-object v3, v0

    invoke-direct {v3}, Ljava/lang/Object;-><init>()V

    move-object v3, v0

    move-object v4, v1

    iput-object v4, v3, Lmalitanyo/webtrafficbotpaid/more_app$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/more_app;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/more_app$100000000;)Lmalitanyo/webtrafficbotpaid/more_app;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/more_app$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/more_app;

    move-object v0, v3

    return-object v0
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/DialogInterface;",
            "I)V"
        }
    .end annotation

    .prologue
    .line 59
    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-object v4, v0

    iget-object v4, v4, Lmalitanyo/webtrafficbotpaid/more_app$100000000;->this$0:Lmalitanyo/webtrafficbotpaid/more_app;

    invoke-virtual {v4}, Lmalitanyo/webtrafficbotpaid/more_app;->finish()V

    return-void
.end method
