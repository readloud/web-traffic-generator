.class Lmalitanyo/webtrafficbotpaid/single$100000004$100000002;
.super Ljava/lang/Object;
.source "single.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmalitanyo/webtrafficbotpaid/single$100000004;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x20
    name = "100000002"
.end annotation


# instance fields
.field private final this$0:Lmalitanyo/webtrafficbotpaid/single$100000004;

.field private final val$modded:Ljava/util/Timer;


# direct methods
.method constructor <init>(Lmalitanyo/webtrafficbotpaid/single$100000004;Ljava/util/Timer;)V
    .locals 6

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v4, v0

    invoke-direct {v4}, Ljava/lang/Object;-><init>()V

    move-object v4, v0

    move-object v5, v1

    iput-object v5, v4, Lmalitanyo/webtrafficbotpaid/single$100000004$100000002;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000004;

    move-object v4, v0

    move-object v5, v2

    iput-object v5, v4, Lmalitanyo/webtrafficbotpaid/single$100000004$100000002;->val$modded:Ljava/util/Timer;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/single$100000004$100000002;)Lmalitanyo/webtrafficbotpaid/single$100000004;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/single$100000004$100000002;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000004;

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
    .line 152
    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-object v4, v0

    iget-object v4, v4, Lmalitanyo/webtrafficbotpaid/single$100000004$100000002;->this$0:Lmalitanyo/webtrafficbotpaid/single$100000004;

    invoke-static {v4}, Lmalitanyo/webtrafficbotpaid/single$100000004;->access$0(Lmalitanyo/webtrafficbotpaid/single$100000004;)Lmalitanyo/webtrafficbotpaid/single;

    move-result-object v4

    invoke-virtual {v4}, Lmalitanyo/webtrafficbotpaid/single;->finish()V

    .line 153
    move-object v4, v0

    iget-object v4, v4, Lmalitanyo/webtrafficbotpaid/single$100000004$100000002;->val$modded:Ljava/util/Timer;

    if-eqz v4, :cond_0

    .line 154
    move-object v4, v0

    iget-object v4, v4, Lmalitanyo/webtrafficbotpaid/single$100000004$100000002;->val$modded:Ljava/util/Timer;

    invoke-virtual {v4}, Ljava/util/Timer;->cancel()V

    :cond_0
    return-void
.end method
